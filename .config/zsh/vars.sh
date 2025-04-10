#!/bin/zsh

# editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Reduce delay for key combinations to 10ms
export KEYTIMEOUT=1
# brew
if command -v brew &> /dev/null; then
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
    if [[ -z "${MANPATH-}" ]]; then
        export MANPATH=":${MANPATH#:}";
    fi
fi
