# Misc
alias ep='echo $PATH | sed "s/:/\\n/g"'
alias lsl="ls -haFG --color" # NOTE: macOS's default ls doesn't take the --color flag

# Toggle theme
alias ct="~/dotfiles/shell/toggle_theme.sh -t"

# Quicker navigation
alias gr='cd $(git rev-parse --show-toplevel)'
alias gnv='cd ~/dotfiles/editor/nvim'
alias gtx='cd ~/dotfiles/shell/tmux'
