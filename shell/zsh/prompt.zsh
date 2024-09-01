#!/bin/zsh

# Enable prompt substitution
setopt PROMPT_SUBST
autoload -U colors && colors

# Prompt segments
time_segment() {
    echo "[%F{cyan}%D{%I:%M}%f]"
}

user_host_segment() {
    echo "[%F{magenta}%n@%m%f]"
}

directory_segment() {
    echo "[%F{green}%~%f]"
}

prompt_line() {
    echo "$1"
}

GIT_INFO=''

# Construct prompt
PROMPT='$(prompt_line "┌─") $(time_segment)-$(user_host_segment)-$(directory_segment)${GIT_INFO}
$(prompt_line "└─")> '

PS2='$(prompt_line ">")'

function precmd() {
    if [[ ! "$(command -v git_info)" ]];then
        echo "Script to fetch basic information about the current repo and it's state failed."
        echo "Aborting."
        return
    fi

    typeset -g PROMPT_FD

    # close last fd if it exists
    if [[ -n "$PROMPT_FD" ]] && { true <&$PROMPT_FD} 2>/dev/null; then
        zle -F "$PROMPT_FD"
        exec {PROMPT_FD}<&-
    fi

    # open new fd
    info="$(git_info --color --zsh)"
    if [[ -n "${info// }" ]]; then
        exec {PROMPT_FD}< <(printf "%b" "-[ $info ]")
    else
        exec {PROMPT_FD}< <()
    fi

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
