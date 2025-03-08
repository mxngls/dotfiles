#!/bin/bash

# Dont link DS_Store files
find . -name ".DS_Store" -exec rm {} \;

# Constants
DOTFILES_DIR="${HOME}/dotfiles"
BACKUPS_DIR="${HOME}/bak"

# Backup current dotfiles if they exist
backup_dotfiles() {

    echo "Backing up current dotfiles..."

    local backup
    backup="${BACKUPS_DIR}/${DOTFILES_DIR}_bk_$(date -u +"%Y%m%d%H%M%S")"

    if [[ ! -p $backup ]]; then
        mkdir -p "$backup"

        if [[ ! -d $DOTFILES_DIR ]]; then
            echo 'No directory containing dotfiles found. Aborting backup process.'
            return 0
        fi

        for file in "${DOTFILES_DIR}"/*; do
            if [ -f "$file" ] || [ -d "$file" ]; then
                cp -R "$file" "$backup"
            fi
        done

        echo "Successfully created new backup of dotfiles directory."
        return 0

    else
        echo 'Up to date backup already exists. Aborting backup process.'
        return 1
    fi
}

# Installing Homebrew if it does not exist yet
install_brew() {
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'Successfully installed Homebrew.'
    else
        echo 'Homebrew is already installed. Continuing trying to install packages.'
    fi

    # Install everything from Brewfile
    echo 'Installing packages installed via Homebrew...'
    if [[ -f "${DOTFILES_DIR}/Brewfile" ]]; then
        brew bundle install --file="${DOTFILES_DIR}/Brewfile"
        echo "Successfully installed Homebrew packages."
    else
        echo 'No Brewfile found. Aborting installation of Homebrew packages.'
    fi

    return 0
}

# Function to create a symbolic link if it doesn't exist
link_file() {
    local source_file="$1"
    local target_file="$2"

    if [[ ! -e "$source_file" ]]; then
        echo "Link failed: $target_file does not exist."
        return 1
    elif [[ ! -e "$target_file" ]]; then
        ln -sfn "$source_file" "$target_file"
        echo "Linked: $target_file."
    else
        echo "Skipped: $target_file already exists."
        return 0
    fi
}

# Function to link files and directories
link_all() {
    echo "Linking files and directories..."

    # Shell related
    link_file "${DOTFILES_DIR}/shell/bash/.bashrc"         "${HOME}/.bashrc"
    link_file "${DOTFILES_DIR}/shell/bash/.bash_login"     "${HOME}/.bash_login"
    link_file "${DOTFILES_DIR}/shell/bash/.bash_logout"    "${HOME}/.bash_logout"
    link_file "${DOTFILES_DIR}/shell/bash/.bash_profile"   "${HOME}/.bash_profile"
    link_file "${DOTFILES_DIR}/shell/bash/.inputrc"        "${HOME}/.inputrc"
    link_file "${DOTFILES_DIR}/shell/tmux"                 "${HOME}/.config/tmux"
    link_file "${DOTFILES_DIR}/shell/alacritty"            "${HOME}/.config/alacritty"
    link_file "${DOTFILES_DIR}/shell/ghostty"              "${HOME}/.config/ghostty"

    # Others
    link_file "${DOTFILES_DIR}/editor/nvim" "${HOME}/.config/nvim"
    link_file "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"

    for script in "${DOTFILES_DIR}/shell/bin/"*; do
        link_file "$script" "/usr/local/bin/$(basename "$script")"
    done

    echo 'Successfully linked all target files.'
}

# Function to clone Git repos (Currently unused!)
clone() {
    local repo="$1"

    # Check if the repository already exists
    if [ ! -d "$repo" ]; then
        echo "Cloning $repo."
        echo "Successfully cloned $repo."
    else
        echo "Skipped: $repo already exists."
    fi
}

# Function to clone external Git repositories
clone_all() {
    cd "${HOME}" || exit

    echo 'Cloning Git repositories...'

    if [[ ! -d ${HOME}/Git ]]; then
        mkdir -p Git && cd Git || exit
        echo 'Created directory to store Git repositories (Git)'
    fi

    return 0
}

# Install
backup_dotfiles
install_brew
link_file
clone_all
