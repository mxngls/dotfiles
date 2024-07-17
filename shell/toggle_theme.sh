#! /bin/zsh -

set -o errexit
set -o nounset
set -o pipefail

# Change neovim colorscheme
change_nvim_colorscheme() {
  for addr in $(/opt/homebrew/bin/nvr --serverlist); do
    if [[ $1 == "Dark" ]]; then
      /opt/homebrew/bin/nvr --servername "$addr" \
        -c "set background=dark" 2> /dev/null
    else
      /opt/homebrew/bin/nvr --servername "$addr" \
        -c "set background=light" 2> /dev/null
    fi
  done
  return 0
}

# Check for the display mode
get_display_mode() {
  if [ -z "$DARKMODE" ]; then
    defaults read -g AppleInterfaceStyle
  else
    if [[ "$DARKMODE" -eq 1 ]]; then
      echo "Dark"
    else
      echo "Light"
    fi
  fi
  return 0
}

main() {
  mode=$(get_display_mode)
  # Check the OS
  if [[ "$(uname -s)" == "Darwin" ]]; then
    OS="Darwin"
    mode=$(get_display_mode)

    change_nvim_colorscheme "$mode"
  fi

  return 0
}

main
