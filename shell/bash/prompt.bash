# Color definitions
CYAN='\[\e[0;36m\]'
MAGENTA='\[\e[0;35m\]'
GREEN='\[\e[0;32m\]'
RESET='\[\e[0m\]'

# Prompt segments
time_segment="[$CYAN\A$RESET]"
user_host_segment="[${MAGENTA}\u@\h${RESET}]"
directory_segment="[${GREEN}\w${RESET}]"

# Construct prompt
PROMPT_COMMAND="prompt_cmd"

PS1="┌─ $time_segment-$user_host_segment-$directory_segment\$GIT_INFO\n└─> "
PS2=">"

prompt_cmd() {
    info="$(git_info --color --bash)"
    if [[ -n "${info// }" ]]; then
        GIT_INFO="$(printf "%b" "-[ $info ]")"
    else
        GIT_INFO=""
    fi
}
