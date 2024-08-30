# Enable prompt substitution
setopt PROMPT_SUBST

git_info() {

    git_oid=""
    git_head=""
    git_upstream=""
    git_ahead=""
    git_behind=""

    oid_reg='# branch\.oid ([a-z0-9]+)'
    head_reg='# branch\.head (.+)'
    upstream_reg='# branch\.upstream (.+)'
    ahead_reg='# branch\.ab (\+[1-9]+) .*'
    behind_reg='# branch\.ab .* (\-[1-9]+)'

    while read -r; do
        if [[ "$REPLY" =~ $oid_reg ]]; then
            git_oid="${BASH_REMATCH[1]}"
        elif [[ "$REPLY" =~ $head_reg ]]; then
            git_head="${BASH_REMATCH[1]}"
        elif [[ "$REPLY" =~ $upstream_reg ]]; then
            git_upstream="${BASH_REMATCH[1]}"
        elif [[ "$REPLY" =~ $ahead_reg || "$REPLY" =~ $behind_reg ]]; then
            git_ahead="${BASH_REMATCH[1]}"
            git_behind="${BASH_REMATCH[2]}"
        fi
    done < <(git \
        --no-optional-locks \
        status \
        --porcelain=v2 \
        --branch)

    printf "%s" "[ "

    printf "%s %s" "${git_oid:0:7}" "$git_head"

    [[ -n "$git_ahead" ]] && printf " %s " "$git_ahead"
    [[ -n "$git_behind" ]] && printf " %s " "$git_behind"

    printf "%s" " ]"
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
