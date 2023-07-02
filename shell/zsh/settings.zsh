# Initialize completion
autoload -Uz compinit && compinit -i
zmodload zsh/complist

zstyle ':completion:*:descriptions' format    '%B> %d%b%'
zstyle ':completion:*:warnings'     format    '%B> No completions!%b'

zstyle ':zle:*'        word-chars             '-_'
zstyle ':completion:*' completer _complete _ignored:complete 
zstyle ':completion:*' glob 1
zstyle ':completion:*' file-sort name
zstyle ':completion:*' group-name             ''
zstyle ':completion:*' list-colors            ''

zstyle ':completion:*' matcher-list           'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' matcher-list           '+r:|[._-/]=* r:|=**' '+l:|[._-/]=* l:|=**'

zstyle ':completion:*' menu                   select=4
zstyle ':completion:*' old-menu               false
zstyle ':completion:*' original               true
zstyle ':completion:*' insert-unambiguous     true 
zstyle ':completion:*' preserve-prefix        '//[^/]##/'
zstyle ':completion:*' special-dirs           true
zstyle ':completion:*' squeeze-slashes        true
zstyle ':completion:*' verbose                true

# Initialize editing command line
autoload -U edit-command-line && zle -N edit-command-line

# Enable interactive comments (# on the command line)
setopt INTERACTIVE_COMMENTS

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
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

# Completions
setopt EXTENDED_GLOB
setopt GLOB_DOTS
setopt GLOB_COMPLETE
setopt COMPLETE_IN_WORD

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
