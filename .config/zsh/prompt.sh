#!/bin/zsh

# load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' (%b)'

# set up the prompt (with git branch name)
setopt PROMPT_SUBST

PROMPT='%n@%m %~%F{green}${vcs_info_msg_0_}%F{%(?.white.red)} $ %f'
