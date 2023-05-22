source ~/.bashrc

#Shell
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

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
if [[ "$(head -n 1 ~/dotfiles/shell/kitty/current-theme.conf | grep -i 'DARK')" == '#DARK' ]]; then
  export PROMPT='%F{244}[%T]%f%  %F{255}%m%f | %F{244}%~%f ${vcs_info_msg_0_}> '
else
  export PROMPT='%F{244}[%T]%f%  %F{0}%m%f | %F{244}%~%f ${vcs_info_msg_0_}> '
fi

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

# source ~/Git/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
