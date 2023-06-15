# Editor
export VISUAL=vim
export EDITOR="$VISUAL"

bindkey -v

# Aliases
alias ls="ls -haFG --color" # NOTE: macOS's default ls doesn't take the --color flag
alias ct="~/dotfiles/shell/toggle_theme.sh -t"
alias gr='cd $(git rev-parse --show-toplevel)'
alias gnv='cd ~/dotfiles/editor/nvim'
