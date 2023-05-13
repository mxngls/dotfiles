#!/bin/bash
# Usage: tmux-move-window.sh <target>
# Example: tmux-move-window.sh 5

# Define a function that moves the current window to a specified index
move_window() {
  # Get the current window index as the source
  source=$(tmux display-message -p '#I')

  # Check if target argument is valid
  if [ -z "$1" ] || [ "$1" -eq "$source" ]; then
    tmux select-window -t "$target"
  else # proceed with moving the window
    # Get the direction of the move
    if [ "$source" -lt "$1" ]; then
      dir=1 # move right
    else
      dir=-1 # move left
    fi

    # Get the minimum and maximum window indexes
    min=$(tmux list-windows -F "#{window_index}" | sort -n | head -n 1)
    max=$(tmux list-windows -F "#{window_index}" | sort -n | tail -n 1)

    # Check if target index is out of range
    if [ "$1" -lt "$min" ]; then
      target=$min # move to first position
    elif [ "$1" -gt "$max" ]; then
      target=$max # move to last position
    else
      target=$1 # move to specified position
    fi

    # Loop over the windows and swap them until the desired position is reached
    for ((i = source; i != target; i += dir)); do
      tmux swap-window -s :$i -t :$((i + dir))
    done

    # Select the moved window
    tmux select-window -t "$target"
  fi # end of if-else statement
}

# Call the function with the target argument
move_window "$1"
