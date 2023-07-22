# Misc
alias ep='echo $PATH | sed "s/:/\\n/g"'
alias ls="ls        --color=always" 
alias lsa="ls -aF   --color=always" 
alias lsl="ls -lah  --color=always"

# Toggle theme
alias ct="~/dotfiles/shell/toggle_theme.sh -t"

# Quicker navigation
alias gr='cd $(git rev-parse --show-toplevel)'
alias gnv='cd ~/dotfiles/editor/nvim'
alias gtx='cd ~/dotfiles/shell/tmux'
