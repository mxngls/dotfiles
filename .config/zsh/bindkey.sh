#!/bin/zsh

# vi keybindings
bindkey -v

# open line in Vim by pressing 'v' in Command-Mode
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# history
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# backspace
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char
