# Colorful man pages
if [[ "$(tput colors)" == "256" ]]; then
  colors256=' -DE210 -DS236.211  -DB210  -DC210 -DR253  -DN253  -Du214 -Dk+253 -Dd+045 -DP253  -Ds+208 -Dk+069'
  colors16='  -DEr   -DSb.r      -DBr    -DCr   -DRw    -DNw    -Duy   -Dk+w   -Dd+0c  -DPw    -Ds+y   -Dk+b'
  less_options="-i -g -j5 -N --mouse --line-num-width 4 --use-color +Gg"
  export MANPAGER="less $less_options $colors256 +Gg"
else
  export MANPAGER="less $less_options $colors16 +Gg"
fi

# Max length for man pages
export MANWIDTH=$((COLUMNS > 80 ? COLUMNS - 10 : COLUMNS))
