#!/bin/zsh

# Add completions installed through Homebrew packages
# See: https://docs.brew.sh/Shell-Completion
if command -v brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

    autoload -Uz compinit
    compinit
fi
