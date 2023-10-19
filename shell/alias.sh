# Misc
alias ep='echo $PATH | sed "s/:/\\n/g"'
alias ls='command gls --color                 '
alias lss='ls -F -1     | sort -k 1.1,1.1 -t .'
alias lsa='ls -aF       | sort -k 1.1,1.1 -t .'
alias lsl='ls -aFlh     | sort -k 1.1,1.1 -t .'
alias me='print -P "%n@%m"'
alias fug='nvim -c '\''if !(&runtimepath =~ "fugitive") | execute "qa" | else | execute "Git | wincmd o" | endif'\'

# Toggle theme
alias ct='~/dotfiles/shell/toggle_theme.sh -t'

# Quicker navigation
alias gr='cd "${$(git rev-parse --git-dir 2>/dev/null)%.git}"'
alias gnv='cd ~/dotfiles/editor/nvim'
alias gtx='cd ~/dotfiles/shell/tmux'

# Some Git stuff
alias gs='git status -sb'
alias gla='git log --graph --format=oneline --abbrev-commit'
alias glu='git log --graph --format=oneline --abbrev-commit @{u}..'
alias glam='git log --graph --format=medium  --abbrev-commit'
alias grs='rename_stash'
alias gls='git stash list --color=always'
alias gdsu='git diff @{u}.. --stat-count=15 --stat-width=80'
alias gds='git diff --stat-count=15 --stat-width=80'
