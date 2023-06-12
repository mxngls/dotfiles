# External plugins (initialized before)

# zsh-completions
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh-completions/src $fpath)
fi
