#!/bin/zsh

# editor (nvim)
if command -v nvim &> /dev/null; then
    export VISUAL=nvim
    export EDITOR="$VISUAL"
else
    export VISUAL=vim
    export EDITOR="$VISUAL"
fi

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

    eval "$(brew shellenv)"
fi
