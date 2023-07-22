# Misc
alias ep='echo $PATH | sed "s/:/\\n/g"'
alias ls="ls        --color=always" 
alias lss="ls       --color=always -1 | sort -k 1.1,1.1 -t ." 
alias lsa="ls -aF   --color=always    | sort -k 1.1,1.1 -t ." 
alias lsl="ls -lh   --color=always    | sort -k 1.1,1.1 -t ."

# Toggle theme
alias ct="~/dotfiles/shell/toggle_theme.sh -t"

# Quicker navigation
alias gr='cd $(git rev-parse --show-toplevel)'
alias gnv='cd ~/dotfiles/editor/nvim'
alias gtx='cd ~/dotfiles/shell/tmux'
