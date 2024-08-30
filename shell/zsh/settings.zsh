# Color directories
export LSCOLORS=dxhxhxhxCxcacagxgxdada

# Initialize completion
autoload -Uz compinit && compinit -i
zmodload zsh/complist

zstyle ':completion:*:descriptions' format    '%B> %d%b%'
zstyle ':completion:*:warnings'     format    '%B> No completions!%b'

zstyle ':zle:*'        word-chars             '-_'
zstyle ':completion:*' completer _complete _expand _ignored:complete 
zstyle ':completion:*' glob 1
zstyle ':completion:*' file-sort name
zstyle ':completion:*' group-name             ''
zstyle ':completion:*' list-colors            ${(s.:.)LS_COLORS}

zstyle ':completion:*' matcher-list           'm:{a-zA-Z}={A-Za-z}' 'r:|[._-/]=* r:|=**' 'l:|[._-/]=* l:|=**'
zstyle ':completion:*' ignore-parents         'parent pwd' 

zstyle ':completion:*' menu                   select=4
zstyle ':completion:*' old-menu               false
zstyle ':completion:*' original               true
zstyle ':completion:*' insert-unambiguous     true 
zstyle ':completion:*' preserve-prefix        '//[^/]##/'
zstyle ':completion:*' special-dirs           true
zstyle ':completion:*' squeeze-slashes        true
zstyle ':completion:*' verbose                true
zstyle ':completion:*' accept-exact-dirs      true

# Initialize editing command line
autoload -U edit-command-line && zle -N edit-command-line

# ZLE
setopt COMBINING_CHARS

# Enable interactive comments (# on the command line)
setopt INTERACTIVE_COMMENTS

# Language
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

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
setopt MENU_COMPLETE
setopt LIST_PACKED

# Compability
setopt BASH_REMATCH
setopt KSH_ARRAYS

# Time to wait for additional characters in a sequence
KEYTIMEOUT=1

# Copy from visual selection to system clipboard
function vi-yank-system {
  zle vi-yank
  echo "$CUTBUFFER" | pbcopy
}
zle -N vi-yank-system

# Use vim style line editing in zsh
bindkey -v
bindkey -a  'gg' beginning-of-buffer-or-history
bindkey -a  'G'  end-of-buffer-or-history
bindkey -a  'u'  undo
bindkey -a  '^R' redo
bindkey -a  'H'  beginning-of-line
bindkey -a  'L'  end-of-line
bindkey -a  '^V' edit-command-line
bindkey -a  '^d' backward-delete-char
bindkey     '^k' history-beginning-search-backward
bindkey     '^j' history-beginning-search-forward
bindkey -M vicmd 'y' vi-yank-system

# Use vim style navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Setup help for builtins
unalias run-help 2> /dev/null
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help="run-help"
