# Misc
alias ep='echo $PATH | sed "s/:/\\n/g"'
alias ls='ls --color=always                   ' 
alias lss='ls -F -1     | sort -k 1.1,1.1 -t .' 
alias lsa='ls -aF       | sort -k 1.1,1.1 -t .' 
alias lsl='ls -aFlh     | sort -k 1.1,1.1 -t .'
alias me='print -P "%n@%m"'

# Toggle theme
alias ct='~/dotfiles/shell/toggle_theme.sh -t'

# Quicker navigation
alias gr='cd "${$(git rev-parse --git-dir 2>/dev/null)%.git}"'
alias gnv='cd ~/dotfiles/editor/nvim'
alias gtx='cd ~/dotfiles/shell/tmux'

# Some Git stuff
alias gs='git status -s'
