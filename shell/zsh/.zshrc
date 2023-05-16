source ~/.bashrc

#Shell
set HISTCONTROL=ignoreboth
set HISTSIZE=1000
set HISTFILESIZE=2000

# Load version control information
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%F{214}%B%b%f '
zstyle ':vcs_info:git:*' actionformats ' GIT ACTION! [%b|%a]'
autoload -Uz compinit
compinit

# Prompt
export PROMPT='%F{244}[%T]%f%  %F{255}%m%f | %F{188}%~%f ${vcs_info_msg_0_}> ' 

# Autocomplete for Homebrew
if type brew &>/dev/null
then
  FPATH=$(brew --prefix)/share/zsh/site-functions:${FPATH}
  autoload -Uz compinit
  compinit
fi

# Autocomplete for ZSH 
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

source ~/Git/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
