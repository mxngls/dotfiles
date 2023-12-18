#!/bin/bash

# Colorful man pages
# B  Binary characters.
# C  Control characters.
# E  Errors and informational messages.
# M  Mark letters in the status column.
# N  Line numbers enabled via the -N option.
# P  Prompts.
# R  The rscroll character.
# S  Search results.
# W  The highlight enabled via the -w option.
# d  Bold text.
# k  Blinking text.
# s  Standout text.
# u  Underlined text.
colors256=' -DE123  -DS0.123  -DB123  -DC123  -DR245  -DN245 -Du158 -Dk+245 -Dd+123 -DP245  -Ds+158 -Dk+158'
colors16='  -DEb    -DSKY     -DBba   -DCb    -DRw    -DNw    -Duy  -Dk+w   -Dd+g   -DPw    -Ds+y   -Dk+y'

if [[ "$(tput colors)" == "256" ]]; then
  less_options="-i -g -j5 -N --mouse --line-num-width 4 --use-color +Gg"
  export MANPAGER="less $less_options $colors256 +Gg"
else
  export MANPAGER="less $less_options $colors16 +Gg"
fi

# Max length for man pages
export MANWIDTH=$((COLUMNS > 80 ? COLUMNS - 10 : COLUMNS))

# Set language
export LANG=en_US.UTF-8
