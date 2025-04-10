#!/bin/sh

if command -v rg >/dev/null 2>&1; then
    export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
fi

if command -v colima >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
    export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
    export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address')
    export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
fi
