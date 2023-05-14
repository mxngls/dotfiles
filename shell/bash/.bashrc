# Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Aliases
alias ls="ls -haFG --color" # NOTE: macOS's default ls doesn't take the --color flag
alias ct="~/dotfiles/shell/toggle_theme.sh -t"
alias gr='cd $(git rev-parse --show-toplevel)'

# Set PATHs 
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export GOPATH=$HOME/Go
# export PATH=/opt/homebrew/bin/pgcli:$PATH
# export PATH=/opt/homebrew/bin/python3:$PATH
# export PATH=/opt/homebrew/bin/nvim:$PATH

# Custom installation (0.8.1)
# export PATH=/Users/max/nvim-macos/bin:$PATH
