# Enable dynamic cursor based on the current input mode
function zle-keymap-select zle-line-init zle-line-finish {
  if [[ $KEYMAP == "viins" || $KEYMAP == "main" ]]; then
    print -n '\033[5 q' # line cursor
  else
    print -n '\033[1 q' # block cursor
  fi
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
