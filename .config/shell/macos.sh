#!/bin/sh

if [ "$(uname)" = "Darwin" ]; then
    # increase key repeat and initial key repeat rate
    defaults write NSGlobalDomain InitialKeyRepeat -int 10 # Normal minimum is 15 (225 ms)
    defaults write NSGlobalDomain KeyRepeat -int 1         # Normal minimum is 2 (30 ms)
fi
