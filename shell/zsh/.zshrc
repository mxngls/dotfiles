# the following lines were added by compinstall

zstyle ':completion:*' completer _list _expand _complete _ignored _match _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=4
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/Users/max/.zshrc'

autoload -Uz compinit
compinit
# end of lines added by compinstall

# history
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY

# misc
setopt extendedglob
setopt nomatch
setopt menu_complete
unsetopt beep

# load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' (%b)'

# set up the prompt (with git branch name)
setopt PROMPT_SUBST

PROMPT='%n@%m %~%F{green}${vcs_info_msg_0_}%F{%(?.white.red)} $ %F{white}'
