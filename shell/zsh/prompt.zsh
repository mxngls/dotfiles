# Enable prompt substitution
setopt PROMPT_SUBST

git_info() {
    git_head="$(git show -s --oneline --pretty='format:%h %d' 2>/dev/null || \
                git name-rev --name-only --no-undefined --always HEAD 2>/dev/null)";

    git_where="${git_head#(refs/heads/|tags/)}"

    if [[ -z "${git_where}" ]]; then
        echo -n ""
    else
        echo "- [ ${git_where} ]"
    fi
}

# Prompt segments
user_host_segment() {
    echo "[ %n@%m ]"
}

directory_segment() {
    echo "[ %~ ]"
}

time_segment() {
    echo "[ %D{%I:%M} ]"
}

prompt_line() {
    echo "$1"
}

GIT_INFO=''

# Construct prompt
PROMPT='$(prompt_line "┌─")$(directory_segment) - $(time_segment) - $(user_host_segment) ${GIT_INFO} 
$(prompt_line "└─")> '

PS2='$(prompt_line ">")'

function precmd() {
    typeset -g PROMPT_FD

    # close last fd if it exists
    if [[ -n "$PROMPT_FD" ]] && { true <&$PROMPT_FD} 2>/dev/null; then
        zle -F "$PROMPT_FD"
        exec {PROMPT_FD}<&-
    fi

    # open new fd
    exec {PROMPT_FD}< <(git_info)

    # set up handler
    zle -F "$PROMPT_FD" read_prompt_fd
}

function read_prompt_fd() {
    # read from fd
    GIT_INFO="$(<&$1)"

    # remove the handler and close the fd
    zle -F "$1"
    exec {1}<&-

    # redisplay
    zle && zle reset-prompt
}
