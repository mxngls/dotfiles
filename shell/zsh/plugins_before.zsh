# External plugins (initialized before)

# zsh-completions
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh-completions/src $fpath)
fi

if type docker &>/dev/null;then
  fpath=($(brew --prefix)/opt/docker-completion/share/zsh/site-functions/ $fpath)
fi
