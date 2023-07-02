# Initialize completion
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu select=4
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist

# Initialize editing command line
autoload -U edit-command-line && zle -N edit-command-line

# Editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Color directories
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Colorful Man pages
source ~/dotfiles/shell/settings.sh

# Extended history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt incappendhistory
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

# Time to wait for additional characters in a sequence
KEYTIMEOUT=1

# Use vim style line editing in zsh
bindkey -v
bindkey -a  'gg' beginning-of-buffer-or-history
bindkey -a  'G'  end-of-buffer-or-history
bindkey -a  'u'  undo
bindkey -a  '^R' redo
bindkey -a  'H' beginning-of-line
bindkey -a  'L' end-of-line
bindkey -a  '^V' edit-command-line
bindkey -a  '^d' backward-delete-char
bindkey     '^k' history-beginning-search-backward
bindkey     '^j' history-beginning-search-forward

# Use vim style navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
