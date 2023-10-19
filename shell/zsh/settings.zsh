# Color directories
export LSCOLORS=dxhxhxhxCxcacagxgxdada
export LS_COLORS='bd=48;5;108;38;5;223;01:ca=01;38;5;95:cd=48;5;108;38;5;223;01:di=01;38;5;223:do=48;5;234;38;5;180;01:ex=01;38;5;108:pi=48;5;234;38;5;180;01:ln=48;5;234;38;5;223:or=48;5;234;38;5;187:ow=48;5;234;38;5;180:su=48;5;234;38;5;66:sg=48;5;234;38;5;66:so=48;5;234;38;5;180;01:st=48;5;180;38;5;234:tw=48;5;180;38;5;234:*.7z=01;38;5;174:*.arj=01;38;5;174:*.bz2=01;38;5;174:*.bz=01;38;5;174:*.gz=01;38;5;174:*.rar=01;38;5;174:*.tar=01;38;5;174:*.tgz=01;38;5;174:*.tbz=01;38;5;174:*.tbz2=01;38;5;174:*.xz=01;38;5;174:*.zip=01;38;5;174:*.apk=01;38;5;95:*.deb=01;38;5;174:*.jad=01;38;5;95:*.jar=01;38;5;95:*.rpm=01;38;5;174:*.bmp=00;38;5;109:*.gif=00;38;5;109:*.ico=00;38;5;109:*.jpg=00;38;5;109:*.JPG=00;38;5;109:*.jpeg=00;38;5;109:*.png=00;38;5;109:*.svg=00;38;5;109:*.xbm=00;38;5;109:*.xpm=00;38;5;109:*.aac=00;38;5;116:*.au=00;38;5;116:*.flac=00;38;5;116:*.mid=00;38;5;116:*.midi=00;38;5;116:*.mka=00;38;5;116:*.mp3=00;38;5;116:*.mpc=00;38;5;116:*.ogg=00;38;5;116:*.ra=00;38;5;116:*.wav=00;38;5;116:*.mov=00;38;5;66:*.mpg=00;38;5;66:*.mpeg=00;38;5;66:*.m2v=00;38;5;66:*.mkv=00;38;5;66:*.ogm=00;38;5;66:*.mp4=00;38;5;66:*.m4v=00;38;5;66:*.mp4v=00;38;5;66:*.vob=00;38;5;66:*.qt=00;38;5;66:*.nuv=00;38;5;66:*.wmv=00;38;5;66:*.asf=00;38;5;66:*.rm=00;38;5;66:*.rmvb=01;38;5;66:*.flc=00;38;5;66:*.avi=00;38;5;66:*.fli=00;38;5;66:*.flv=00;38;5;66:*.gl=00;38;5;66:*.m2ts=00;38;5;66:*.divx=00;38;5;66:*.webm=00;38;5;66:*.awk=00;38;5;151:*.bash=00;38;5;151:*.bat=00;38;5;151:*.BAT=00;38;5;151:*.sed=00;38;5;151:*.sh=00;38;5;151:*.zsh=00;38;5;151:*CMakeLists.txt=00;38;5;187:*.cabal=00;38;5;187:*Makefile=00;38;5;187:*.mk=00;38;5;187:*.make=00;38;5;187:*.c=01;38;5;187:*.h=01;38;5;187:*.s=01;38;5;187:*.cs=01;38;5;187:*.java=01;38;5;187:*.scala=01;38;5;187:*.hs=01;38;5;187:*.py=01;38;5;187:*.rb=01;38;5;187:*.php=01;38;5;187:*.pl=01;38;5;187:*.vim=01;38;5;187:*.js=01;38;5;187:*.coffee=01;38;5;187:*.go=01;38;5;187:*.lisp=01;38;5;187:*.scm=01;38;5;187:*.txt=04;38;5;188:*.tex=04;38;5;188:*.html=04;38;5;188:*.xhtml=04;38;5;188:*.xml=04;38;5;188:*.md=04;38;5;188:*.mkd=04;38;5;188:*.markdown=04;38;5;188:*.org=04;38;5;188:*.pandoc=04;38;5;188:*.pdc=04;38;5;188:*.pdf=04;38;5;188:*rc=04;38;5;180:*.conf=04;38;5;180:*Dockerfile=04;38;5;180:*README=04;38;5;187:*LICENSE=04;38;5;187:*AUTHORS=04;38;5;187:*.gitignore=00;38;5;248:*.gitmodules=00;38;5;248:*.log=00;38;5;234:*.bak=00;38;5;234:*.aux=00;38;5;234:*.toc=00;38;5;234:*~=00;38;5;234:*#=00;38;5;234:*.swp=00;38;5;234:*.tmp=00;38;5;234:*.temp=00;38;5;234:*.o=00;38;5;234:*.pyc=00;38;5;234:*.class=00;38;5;234:*.cache=00;38;5;234:*.pacnew=48;5;95;38;5;108:*.pacsave=48;5;95;38;5;108:*.pacorig=48;5;95;38;5;108:*PKGBUILD=00;38;5;110:*.rpmsave=48;5;95;38;5;108:*.rpmorig=48;5;95;38;5;108:*.rpmnew=48;5;95;38;5;108:*.spec=00;38;5;110:';

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
export VISUAL=vim
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

# Time to wait for additional characters in a sequence
KEYTIMEOUT=1

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

# Use vim style navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
