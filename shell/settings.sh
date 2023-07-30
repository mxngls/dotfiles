# Colorful man pages
if [[ "$(tput colors)" == "256" ]]; then
  
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

  colors256=' -DE064  -DS0.064  -DB064  -DC064  -DR245  -DN245 -Du033 -Dk+245 -Dd+064 -DP245  -Ds+033 -Dk+033'
  colors16='  -DEg    -DSKY     -DBga   -DCg    -DRw    -DNw    -Dub  -Dk+w   -Dd+g   -DPw    -Ds+b   -Dk+b'
  less_options="-i -g -j5 -N --mouse --line-num-width 4 --use-color +Gg"
  export MANPAGER="less $less_options $colors256 +Gg"
else
  export MANPAGER="less $less_options $colors16 +Gg"
fi

# Max length for man pages
export MANWIDTH=$((COLUMNS > 80 ? COLUMNS - 10 : COLUMNS))

# Set language
export LANG=en_US.UTF-8
