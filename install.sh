#!/bin/bash

set -eu

# Dont link DS_Store files
find . -name ".DS_Store" -exec rm {} \;

# {{{ Backup current dotfiles
function backup_dotfiles() {
  echo "> Backing up current dotfiles..."

  local backup_dir
  backup_dir="dotfile_bk_$(date -u +"%Y%m%d%H%M%S")"
  cd && mkdir -p "$backup_dir"

  for el in "${HOME}/dotfiles"/*; do
    if [ -f "$el" ] || [ -d "$el" ]; then
      cp -R "$el" "$backup_dir"
    fi
  done

  echo -e "Done!\n"
}

backup_dotfiles

# }}}

# {{{ Install homebrew
function install_brew() {
  if ! command -v brew &> /dev/null; then
    echo "> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   
    echo -e "Done!\n"
  else
    echo "> Homebrew is already installed"
  fi

  # Install everything from Brewfile
  echo "> Installing packages installed via Homebrew..."
  brew bundle install --file=~/dotfiles/Brewfile

  echo -e "Done!\n"
}

install_brew

# }}}

# {{{ Linking
function link_all() {
  echo "> Linking files and directories"

  cd "${HOME}"/dotfiles
  
  # Shell
  ln -sfn "$(pwd)"/shell/zsh/.zshenv            "${HOME}".zshenv
  ln -sfn "$(pwd)"/shell/zsh/.zshrc             "${HOME}".zshrc
  ln -sfn "$(pwd)"/shell/bash/.bashrc           "${HOME}".bashrc
  ln -sfn "$(pwd)"/shell/bash/.bash_login       "${HOME}".bash_login
  ln -sfn "$(pwd)"/shell/bash/.bash_logout      "${HOME}".bash_logout
  ln -sfn "$(pwd)"/shell/bash/.bash_profile     "${HOME}".bash_profile
  ln -sfn "$(pwd)"/shell/tmux                   "${HOME}".config
  ln -sfn "$(pwd)"/shell/kitty                  "${HOME}".config

  # Rest
  ln -sfn "$(pwd)"/editor/nvim                  "${HOME}".config/
  ln -sfn "$(pwd)"/.gitconfig                   "${HOME}".gitconfig

  echo -e "Done!\n"
  echo "> All files linked! Ready to go!"
}

link_all

# }}}

# {{{ Set up external repos that that can't be managed via Homebrew
function get_other() {
  cd "${HOME}"
  mkdir -p Git && cd "$_"
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
}

# }}}

# {{{ Set termial/vim theme
if [[ "$(uname -s)" == "Darwin" ]]; then
  swiftc dark-mode-notify.swift -o dark-mode-notify
  ln -sfn ~/dotfiles/shell/com.mxngls.dark-mode-notify.plist ~/Library/LaunchAgents/
  launchctl load -w ~/Library/LaunchAgents/com.mxngls.dark-mode-notify.plist
fi

# }}}
