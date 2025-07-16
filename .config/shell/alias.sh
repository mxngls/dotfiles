# misc
alias ep='echo $PATH | sed "s/:/\\n/g"'
alias ls='ls --color=always'
alias lss='ls -F -1'
alias lsa='ls -aF -1'
alias lsl='ls -aFlh'
alias me='print -P "%n@%m"'

# Fugitive
alias fug='$EDITOR -c '\''if !(&runtimepath =~ "fugitive") | execute "qa" | else | execute "Git | wincmd o" | endif'\'

# quicker navigation
alias cdr='cd "$(git rev-parse --show-toplevel 2>/dev/null)"'

# Some Git stuff
alias gap='git add -p'
alias gds='git diff --staged'
alias gla='git log --graph --format=oneline --abbrev-commit -n 10 --first-parent'
alias glam='git log --graph --format=medium  --abbrev-commit -n 10 --first-parent'
alias glu='git log --graph --format=oneline --abbrev-commit -n 10 @{u}..'
alias gs='git status -sb -uall'

# journal
alias ce='git commit -m "Add entry ($(date +%Y-%m-%d))"'
