# External plugins (initialized after)

# Syntax highlighting

if type brew &>/dev/null; then
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
