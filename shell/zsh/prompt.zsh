# Allow for variable/function substitution in prompt
setopt prompt_subst

# Load color variables to make it easier to color things
autoload -U colors && colors

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

    echo "%{$fg[default]%}${truncated}%{$fg[yellow]%}%B${last}%b%{$reset_color%}"
}

# An exclamation point if the previous command did not complete successfully
function PR_ERROR() {
    echo "%(?..%(!.%{$fg[violet]%}.%{$fg[red]%})%B!%b%{$reset_color%} )"
}

# The arrow in red (for root) or violet (for regular user)
function PR_ARROW() {
    echo "%(!.%{$fg[red]%}.%{$fg[violet]%})%B>%b%{$reset_color%}"
}

# Set custom rhs prompt
# User in red (for root) or violet (for regular user)
function RPR_USER() {
    echo "%(!.%{$fg[red]%}.%{$fg[violet]%})%B%n%b%{$reset_color%}"
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
function RPR_HOST() {
    echo "%{$fg[default]%}$(machine_name)%{$reset_color%}"
}

# Build the rhs prompt
function RPR_INFO() {
    echo "$(RPR_USER)%{$fg[233]%}@%{$reset_color%}$(RPR_HOST)"
}

# Set RHS prompt for git repositories
DIFF_SYMBOL="-"
GIT_PROMPT_DELIMITER=" "
GIT_PROMPT_AHEAD="%{$fg[green]%}%B+NUM%b%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[red]%}%B-NUM%b%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg[cyan]%}%Bx%b%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg[red]%}%B$DIFF_SYMBOL%b%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg[yellow]%}%B$DIFF_SYMBOL%b%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg[green]%}%B$DIFF_SYMBOL%b%{$reset_color%}"
GIT_PROMPT_DETACHED="%{$fg[blue]%}%B!%b%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
function parse_git_branch() {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
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
    local GIT_STATE="" GIT_DIFF=""

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

    if [[ -n $(git ls-files --other --exclude-standard :/ 2> /dev/null) ]]; then
    GIT_DIFF=$GIT_PROMPT_UNTRACKED
    fi

    if ! git diff --quiet 2> /dev/null; then
    GIT_DIFF=$GIT_DIFF$GIT_PROMPT_MODIFIED
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
    GIT_DIFF=$GIT_DIFF$GIT_PROMPT_STAGED
    fi

    if [[ -n $GIT_STATE && -n $GIT_DIFF ]]; then
        GIT_STATE="$GIT_STATE "
    fi
    GIT_STATE="$GIT_STATE$GIT_DIFF"

    if [[ -n $GIT_STATE ]]; then
    echo "$GIT_STATE"
    fi
}

# If inside a Git repository, print its branch and state
function git_prompt_string() {
    local git_where="$(parse_git_branch)"
    local git_detached="$(parse_git_detached)"
    [ -n "$git_where" ] && echo "%{$fg[white]%}%B${git_where#(refs/heads/|tags/)}%b$git_detached$GIT_PROMPT_DELIMITER$(parse_git_state)"
}

# Prompt
function PCMD() {
    echo "$(PR_DIR 2) $(PR_ERROR)$(PR_ARROW) " # space at the end
}

PROMPT='$(PCMD)'  # single quotes to prevent immediate execution
RPROMPT=''        # set asynchronously and dynamically

# Right-hand prompt
function RCMD() {
    echo "$(git_prompt_string) | $(RPR_INFO)"
}

# Enable dynamic cursor based on the current input mode
function zle-keymap-select zle-line-init zle-line-finish() {
  if [[ $KEYMAP == "viins" || $KEYMAP == "main" ]]; then
    print -n '\033[5 q' # line cursor
  else
    print -n '\033[1 q' # block cursor
  fi
}

function precmd() {
    typeset -g _PROMPT_ASYNC_FD

    # close last fd, we don't care about the result anymore
    if [[ -n "$_PROMPT_ASYNC_FD" ]] && { true <&$_PROMPT_ASYNC_FD } 2>/dev/null; then
        exec {_PROMPT_ASYNC_FD}<&-
    fi

    # compute prompt in a background process
    exec {_PROMPT_ASYNC_FD}< <(printf "%s" "$(RCMD)")

    # when fd is readable, call response handler
    zle -F "$_PROMPT_ASYNC_FD" async_prompt_complete

    # set cursor shape
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
    zle && zle 
}
