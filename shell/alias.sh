# Misc
alias ep='echo $PATH | sed "s/:/\\n/g"'
alias eh='echo $USER@$HOST'
alias ls='ls --color=always'
alias lss='ls -F -1'
alias lsa='ls -aF -1'
alias lsl='ls -aFlh'
alias me='print -P "%n@%m"'
alias fug='nvim -c '\''if !(&runtimepath =~ "fugitive") | execute "qa" | else | execute "Git | wincmd o" | endif'\'
alias lc='last_commit'

# Toggle theme
alias ct='~/dotfiles/shell/toggle_theme.sh -t'

# Quicker navigation
alias gr='cd "${$(git rev-parse --git-dir 2>/dev/null)%.git}"'
alias gnv='cd ~/dotfiles/editor/nvim'
alias gtx='cd ~/dotfiles/shell/tmux'

# Some Git stuff
alias gs='git status -sb -uall'
alias gla='git log --graph --format=oneline --abbrev-commit -n 10'
alias glu='git log --graph --format=oneline --abbrev-commit -n 10 @{u}..'
alias glam='git log --graph --format=medium  --abbrev-commit -n 10'
alias grs='rename_stash'
alias gls='git stash list --color=always'
alias gdsu='git diff @{u}.. --stat-count=15 --stat-width=80'
alias gds='git diff --stat-count=15 --stat-width=80'
alias gdi='git diff --staged'

# Misc
alias ce='git commit -m "Add entry ($(date +%Y-%m-%d))"'
