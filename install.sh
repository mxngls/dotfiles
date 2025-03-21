#!/bin/bash

# Dont link DS_Store files
find . -name ".DS_Store" -exec rm {} \;

# Constants
DOTFILES_DIR="${HOME}/dotfiles"
BACKUPS_DIR="${HOME}/bak"

# Backup current dotfiles if they exist and have changed
backup_dotfiles() {
    echo "Checking if dotfiles backup is needed..."

    # Skip if dotfiles directory doesn't exist
    if [[ ! -d $DOTFILES_DIR ]]; then
        echo 'No directory containing dotfiles found. Skipping backup process.'
        return 0
    fi

    # Create backups directory if it doesn't exist
    if [[ ! -d $BACKUPS_DIR ]]; then
        mkdir -p "$BACKUPS_DIR"
    fi

    # Check if we have a previous backup to compare against
    local last_backup
    last_backup=$(find "$BACKUPS_DIR" -name "${DOTFILES_DIR##*/}_bk_*" -type d | sort -r | head -n1)

    # If no previous backup exists, create one
    if [[ -z $last_backup ]]; then
        local new_backup
        new_backup="${BACKUPS_DIR}/${DOTFILES_DIR##*/}_bk_$(date -u +"%Y%m%d%H%M%S")"
        mkdir -p "$new_backup"

        echo "Creating initial backup of dotfiles..."
        for file in "${DOTFILES_DIR}"/*; do
            if [ -f "$file" ] || [ -d "$file" ]; then
                cp -R "$file" "$new_backup"
            fi
        done
        echo "Successfully created initial backup of dotfiles directory."
        return 0
    fi

    # Check if files have changed since last backup
    local changes_found=0
    for file in "${DOTFILES_DIR}"/*; do
        if [ -f "$file" ] || [ -d "$file" ]; then
            local basename
            basename=$(basename "$file")
            if ! cmp -s "$file" "$last_backup/$basename" 2>/dev/null; then
                changes_found=1
                break
            fi
        fi
    done

    # If changes found, create a new backup
    if [[ $changes_found -eq 1 ]]; then
        local new_backup
        new_backup="${BACKUPS_DIR}/${DOTFILES_DIR##*/}_bk_$(date -u +"%Y%m%d%H%M%S")"
        mkdir -p "$new_backup"

        echo "Changes detected, creating new backup..."
        for file in "${DOTFILES_DIR}"/*; do
            if [ -f "$file" ] || [ -d "$file" ]; then
                cp -R "$file" "$new_backup"
            fi
        done
        echo "Successfully created new backup of dotfiles directory."
    else
        echo "No changes detected since last backup. Skipping backup process."
    fi

    return 0
}

# Installing Homebrew if it does not exist yet
install_brew() {
    if ! command -v brew &>/dev/null; then
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

# Function to create a symbolic link if it doesn't exist or points to a different location
link_file() {
    local source_file="$1"
    local target_file="$2"

    if [[ ! -e "$source_file" ]]; then
        echo "Link failed: $source_file does not exist."
        return 1
    elif [[ -L "$target_file" ]]; then
        # Check if the existing symlink points to our source file
        local current_target
        current_target=$(readlink "$target_file")
        if [[ "$current_target" == "$source_file" ]]; then
            echo "Skipped: $target_file is already linked to $source_file."
        else
            echo "Updating: $target_file was linked to $current_target, now linking to $source_file."
            ln -sfn "$source_file" "$target_file"
        fi
    elif [[ -e "$target_file" ]]; then
        echo "Warning: $target_file exists but is not a symlink. Skipping."
        return 0
    else
        echo "Linking: $target_file to $source_file."
        ln -sfn "$source_file" "$target_file"
    fi
}

# Function to link files and directories
link_all() {
    echo "Linking files and directories..."

    # Shell related
    link_file "${DOTFILES_DIR}/shell/bash/.bashrc" "${HOME}/.bashrc"
    link_file "${DOTFILES_DIR}/shell/bash/.bash_login" "${HOME}/.bash_login"
    link_file "${DOTFILES_DIR}/shell/bash/.bash_logout" "${HOME}/.bash_logout"
    link_file "${DOTFILES_DIR}/shell/bash/.bash_profile" "${HOME}/.bash_profile"
    link_file "${DOTFILES_DIR}/shell/bash/.inputrc" "${HOME}/.inputrc"
    link_file "${DOTFILES_DIR}/shell/tmux" "${HOME}/.config/tmux"
    link_file "${DOTFILES_DIR}/shell/alacritty" "${HOME}/.config/alacritty"
    link_file "${DOTFILES_DIR}/shell/ghostty" "${HOME}/.config/ghostty"

    # Others
    link_file "${DOTFILES_DIR}/editor/nvim" "${HOME}/.config/nvim"
    link_file "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"

    for script in "${DOTFILES_DIR}/shell/bin/"*; do
        link_file "$script" "/usr/local/bin/$(basename "$script")"
    done

    echo 'Successfully linked all target files.'
}

# Install
backup_dotfiles
install_brew
link_all
