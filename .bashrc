#!/bin/bash

# if not running interactively, don't do anything
if [[ $- != *i* ]]; then
    return
fi

# be nice to sysadmins
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# include supplementary config files
local_config_dir="$HOME/.config/bash"
if [[ -d "$local_config_dir" ]]; then
    for file in "$local_config_dir"/*.sh; do
        source "$file"
    done
fi

# include shared config files
shared_config_dir="$HOME/.config/shell"
if [[ -d "$shared_config_dir" ]]; then
    for file in "$shared_config_dir"/*.sh; do
        source "$file"
    done
fi
