#!/bin/sh

# standard path
export PATH=""

path_add() {
    if [ -d "$1" ]; then
        old_path=":${PATH}:"
        [ "${old_path%:"$1":*}" = "$old_path" ] && PATH="$PATH:$1"
        PATH="${PATH#:}"
        PATH="${PATH%:}"
        unset old_path
        export PATH
    fi
}

path_remove() {
    old_path=":${PATH}:"
    if [ "${old_path%:"$1":*}" != "$old_path" ]; then
        new_path=""
        IFS=:
        for p in $PATH; do
            if [ "$p" != "$1" ]; then
                if [ -z "$new_path" ]; then
                    new_path="$p"
                else
                    new_path="$new_path:$p"
                fi
            fi
        done
        PATH="$new_path"
        unset new_path
    fi
    PATH="${PATH#:}"
    PATH="${PATH%:}"
    unset old_path
    export PATH
}

# Homebrew
path_add "/opt/homebrew/bin"
path_add "/opt/homebrew/sbin"

# local
path_add "/usr/local/bin"
path_add "/usr/local/sbin"

# other custom local executables
path_add "$HOME/.local/bin"

# standard OSX path
path_add "/usr/bin"
path_add "/bin"
path_add "/usr/sbin"
path_add "/sbin"
