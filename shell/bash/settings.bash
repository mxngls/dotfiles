# Color directories
export LSCOLORS=dxhxhxhxCxcacagxgxdada

# Language
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Extended history
HISTSIZE=100000
HISTFILESIZE=$HISTSIZE
HISTFILE=~/.bash_history
HISTCONTROL=ignoreboth:erasedups

shopt -s histappend
shopt -s dotglob
shopt -s checkwinsize

# Use vim style line editing in bash
set -o vi

# Setup help for builtins
alias help='help'

# Completions
HOMEBREW_PREFIX="$(brew --prefix)"
if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
fi
