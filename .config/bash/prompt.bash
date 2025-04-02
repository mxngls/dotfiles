# Construct prompt
PROMPT_COMMAND="prompt_cmd"

PS1="\u@\h$GIT_INFO\n $ "

prompt_cmd() {
    info="$(git_info --color --bash)"
    if [[ -n "${info// /}" ]]; then
        GIT_INFO=" $(printf "%b" "-[ $info ]")"
    else
        GIT_INFO=""
    fi

    # Append to history immediately
    history -a
}
