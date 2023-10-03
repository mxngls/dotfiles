# Allow for variable/function substitution in prompt
setopt prompt_subst

# Load color variables to make it easier to color things
autoload -U colors && colors

# An exclamation point if the previous command did not complete successfully
function PR_ERROR() {
  echo "%(?..%(!.%{$fg[white]%}.%{$fg[red]%})%B!%b%{$reset_color%} )"
}

# The arrow in red (for root) or violet (for regular user)
function PR_DOLLAR() {
  echo "%(!.%{$fg[red]%}.%{$fg[white]%})%B$%b%{$reset_color%}"
}

# Set custom rhs prompt
# User in red (for root) or violet (for regular user)
function PR_USER() {
  echo "%(!.%{$fg[red]%}.%F{223})%B%n%b%F{reset}"
}

# Get machine information
function machine_name() {
  if [[ -f $HOME/.name ]]; then
    cat $HOME/.name
  else
    hostname
  fi
}

# Show host information
function PR_HOST() {
  echo "%F{223}$(machine_name)%F{reset}"
}

# Build the rhs prompt
function PR_INFO() {
  echo "$(PR_USER)%F{223}@%F{reset}$(PR_HOST)"
}

# Current directory, truncated to n path elements (or n+1 when one of them is "~")
# The number of elements to keep can be specified as ${1}
function PR_DIR() {
  local sub=$1
  local len="$(expr ${sub} + 1)"
  local full="$(print -P "%d")"
  local relfull="$(print -P "%~")"
  local shorter="$(print -P "%${len}~")"
  local current="$(print -P "%${len}(~:.../:)%${sub}~")"
  local last="$(print -P "%1~")"

    # Longer path for '~/...'
    if [[ "${shorter}" == \~/* ]]; then
      current=${shorter}
    fi

    local truncated="$(echo "${current%/*}/")"

    # Handle special case of directory '/' or '~something'
    if [[ "${truncated}" == "/" || "${relfull[2,-2]}" != */* ]]; then
      truncated=""
    fi

    # Handle special case of last being '/...' one directory down
    if [[ "${full[2,-1]}" != "" && "${full[2,-1]}" != */* ]]; then
      truncated="/"
      last=${last[2,-1]} # take substring
    fi

    echo "%{$fg[white]%}${truncated}%B${last}%b%{$reset_color%}"
  }

# Set RHS prompt for git repositories
DIFF_SYMBOL="-"
GIT_PROMPT_DELIMITER=" "
GIT_PROMPT_SUB_DELIMITER=":"
GIT_PROMPT_AHEAD="%{$fg[green]%}%B+NUM%b%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[red]%}%B-NUM%b%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg[white]%}%Bx%b%{$reset_color%}"
GIT_PROMPT_DETACHED="%{$fg[white]%}%B!%b%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
function parse_git_branch() {
  ( \ 
    git symbolic-ref -q HEAD || \
    git name-rev --name-only --no-undefined --always HEAD \
    ) 2> /dev/null
}

# Indicate if head is detached
function parse_git_detached() {
  if ! git symbolic-ref HEAD >/dev/null 2>&1; then
    echo "${GIT_PROMPT_DETACHED}"
  fi
}

# Show different symbols as appropriate for various Git repository states
function parse_git_state() {
  # Compose this value via multiple conditional appends.
  local GIT_STATE="" 
  local GIT_DIFF_ELEMENTS=()

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    if [[ -n $GIT_STATE ]]; then
      GIT_STATE="$GIT_STATE "
    fi
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    if [[ -n $GIT_STATE ]]; then
      GIT_STATE="$GIT_STATE "
    fi
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_STATE"
  fi
}

# If inside a Git repository, print its branch and state
function git_prompt_string() {
  local git_where="${$(parse_git_branch)#(refs/heads/|tags/)}"
  local git_detached="$(parse_git_detached)"
  [ -n "$git_where" ] && echo \
    "${git_where}$git_detached$GIT_PROMPT_DELIMITER$(parse_git_state)"
}

# Prompt
function PCMD() {
  echo "$(PR_INFO): $(PR_DIR 2) $(PR_ERROR)$(PR_DOLLAR) " # space at the end
}

PROMPT='$(PCMD)'  # single quotes to prevent immediate execution
RPROMPT=''        # set asynchronously and dynamically

# Right-hand prompt
function RCMD() {
  if [[ -n "$(git_prompt_string)" ]]; then
    echo "$(git_prompt_string)"
  fi
}

function zle-line-finish zle-line-init zle-keymap-select() {
  # set the cursor
  printf "\033[2 q\033]12;white\007"
}

function precmd() {
  typeset -g _PROMPT_ASYNC_FD

    # close last fd, we don't care about the result anymore
    if [[ -n "$_PROMPT_ASYNC_FD" ]] && \
      { true <&$_PROMPT_ASYNC_FD } 2>/dev/null; then
      exec {_PROMPT_ASYNC_FD}<&-
    fi

    # compute prompt in a background process
    exec {_PROMPT_ASYNC_FD}< <(printf "%s" "$(RCMD)")

    # when fd is readable, call response handler
    zle -F "$_PROMPT_ASYNC_FD" async_prompt_complete

    # unify cursor shape
    zle -N zle-line-init
    zle -N zle-line-finish
    zle -N zle-keymap-select

    # do not clear RPROMPT, let it persist
  }

  function async_prompt_complete() {
    # read from fd
    RPROMPT="$(<&$1)"

    # remove the handler and close the fd
    zle -F "$1"
    exec {1}<&-

    # redisplay
    zle && zle reset-prompt
  }
