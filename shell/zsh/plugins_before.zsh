# External plugins (initialized before)

# zsh-completions
if type brew &> /dev/null; then
  # Completions for homebrew itself
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

  # Completions installed via Zsh-Completions
  fpath=($(brew --prefix)/share/zsh-completions/src $fpath)

  # completions for docker
  if type docker &> /dev/null;then
    fpath=($(brew --prefix)/opt/docker-completion/share/zsh/site-functions/ $fpath)
  fi

  # Needed for aws
  if type aws &> /dev/null;then
    autoload bashcompinit && bashcompinit
    complete -C '/opt/homebrew/bin/aws_completer' aws
  fi
fi

# custom completion functions
fpath=(/Users/max/dotfiles/shell/zsh/completions/ $fpath)
