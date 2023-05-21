#!/bin/bash

# Change neovim colorscheme
change_colorscheme() {
  for addr in $(/opt/homebrew/bin/nvr --serverlist); do
    if [[ $1 == "Dark" ]]; then
      /opt/homebrew/bin/nvr --servername "$addr" -c "set background=dark" 2> /dev/null
    else
      /opt/homebrew/bin/nvr --servername "$addr" -c "set background=light" 2> /dev/null
    fi
  done
}

# Check for the display mode
get_display_mode() {
  if [[ "$OS" == "Darwin" ]]; then
    if [ -z "$DARKMODE" ]; then
      defaults read -g AppleInterfaceStyle
    else
      if [[ "$DARKMODE" -eq 1 ]]; then
        echo "Dark"
      else
        echo "Light"
      fi
    fi
  elif [[ "$OS" == "Ubuntu" ]]; then
    if gsettings get org.gnome.desktop.interface gtk-theme | grep -q "Dark";then
      echo "Dark"
    else
      echo "Light"
    fi
  fi
}

# Switch Kitty and Neovim's theme based on the display mode
switch_theme() {
  if [[ "$1" == "Dark" ]]; then
    /opt/homebrew/bin/kitty +kitten themes --reload-in=all "Solarized Dark"
  else
    /opt/homebrew/bin/kitty +kitten themes --reload-in=all "Solarized Light"
  fi
  change_colorscheme "$1"
}

# Check the OS
if [[ "$(uname -s)" == "Darwin" ]]; then
  # OSX
  OS="Darwin"
elif [[ "$(uname -s)" == "Linux" && -n "$(command -v lsb_release)" && "$(lsb_release -si)" == "Ubuntu" ]]; then
  # Ubuntu
  OS="Ubuntu"
fi

# Check for optional input flag
if [[ "$1" != "-t" ]]; then
  mode=$(get_display_mode)
else
  if [[ "$(head -n 1 ~/dotfiles/shell/kitty/current-theme.conf | grep -i "#DARK")" == "#DARK" ]]; then
    mode="Light"
  else
    mode="Dark"
  fi
fi

switch_theme "$mode"

source ~/.zshrc

exit
