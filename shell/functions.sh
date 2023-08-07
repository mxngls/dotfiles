#!/bin/bash

# Function to rename a Git stash
# Parameters:
#   $1: The index of the stash to rename
#   $2: The new name for the stash
rename_stash() {
    set -eu
     
    local stash_index="$1"
    local new_stash_name="$2"
    local stashes_total=$(($(git stash list | wc -l) - 1))

    if [[ -z "$stash_index" ]] || [[ -z "$new_stash_name" ]]; then
      echo "Invalid input: Both the stash index and a new stash name are required."
      return 1  
    elif [[ "$stash_index" -gt "$stashes_total" ]] || [[ "$stash_index" -lt 0 ]]; then
      echo "Invalid input: No stash with the specifed index exists."
      return 1
    fi

    local stash_info=($(git show --no-patch --pretty=format:"%T %P" stash@{$stash_index} | sed -e 's/ / -p /g'))

    # Get the commit for our new stash
    local new_commit_hash=$(git commit-tree "${stash_info[@]}" -m "$new_stash_name")

    # Drop the old stash
    git stash drop --quiet stash@{$stash_index} 

    # Create a new one in its place
    git stash store \
      -m "$(git show -s --format=%B $new_commit_hash)" \
      --quiet \
      $new_commit_hash

    echo "Renamed stash@{$stash_index} as '$new_stash_name'"
    return 0
}

# Create a new note or modify its date if it already exists
note() { 
  new_note="$(date +%Y-%m-%d_%H).md"
  touch "$new_note"
  # That doesn't work if it has no lines to operate on
  if [[ $(echo -n "$new_note" | wc -l | bc ) == 0 ]]; then 
    echo -e '\n' > "$new_note" 
  fi 
  sed -i "" -e "1s/^/# $(date)\n/" "$new_note";
  vim "$new_note"
}

