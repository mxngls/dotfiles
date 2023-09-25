# External plugins (initialized before)

# zsh-completions
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh-completions/src $fpath)
fi

# completions for docker
if type docker &>/dev/null;then
  fpath=($(brew --prefix)/opt/docker-completion/share/zsh/site-functions/ $fpath)
fi

# custom completion functions
fpath=(/Users/max/dotfiles/shell/zsh/completions/ $fpath)
