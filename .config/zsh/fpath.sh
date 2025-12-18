#!/bin/zsh

# Add completions installed through Homebrew packages
# See: https://docs.brew.sh/Shell-Completion
if command -v brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Add Rust/Cargo completions
if command -v rustc &>/dev/null; then
    FPATH="$(rustc --print sysroot)/share/zsh/site-functions:${FPATH}"
fi
