# Misc
alias ep='echo $PATH | sed "s/:/\\n/g"'
alias ls='ls --color=always'
alias lss='ls -F -1'
alias lsa='ls -aF -1'
alias lsl='ls -aFlh'
alias me='print -P "%n@%m"'
alias fug='$EDITOR -c '\''if !(&runtimepath =~ "fugitive") | execute "qa" | else | execute "Git | wincmd o" | endif'\'

# Quicker navigation
alias cdr='cd "$(git rev-parse --show-toplevel 2>/dev/null)"'
alias cdn="cd \$HOME/.config/editor/nvim"

# Some Git stuff
alias gap='git add -p'
alias gdi='git diff --staged'
alias gds='git diff --stat-count=15 --stat-width=80'
alias gdsu='git diff @{u}.. --stat-count=15 --stat-width=80'
alias gla='git log --graph --format=oneline --abbrev-commit -n 10 --first-parent'
alias glam='git log --graph --format=medium  --abbrev-commit -n 10 --first-parent'
alias gls='git stash list --color=always'
alias glu='git log --graph --format=oneline --abbrev-commit -n 10 @{u}..'
alias grs='rename_stash'
alias glc='last_commit'
alias gs='git status -sb -uall'

# Journal
alias ce='git commit -m "Add entry ($(date +%Y-%m-%d))"'
