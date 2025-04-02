# language
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Editor
export VISUAL=vim
export EDITOR="$VISUAL"

# history
HISTSIZE=100000
HISTFILESIZE="$HISTSIZE"
HISTFILE="$HOME/.bash_history"

export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

shopt -s histappend   # ensures history from multiple terminals gets appended
shopt -s dotglob      # makes globs match hidden files
shopt -s checkwinsize # keeps line wrapping correct when resizing terminal

# vi keybindgins
set -o vi
