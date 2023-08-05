# External plugins (initialized after)

# Syntax highlighting

if type brew &>/dev/null; then
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Remove underline for paths
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
