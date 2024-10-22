#!/usr/bin/env bash

# This script is run at startup when Hyprland starts.

# NOTE: SSH_AGENT_ENV is not written when the ssh-agent is already running
# In this dotfile setup, ssh-agent.env is sourced in `.zshrc`.
if [ -z "${SSH_AGENT_PID}" ] || [ -z "${SSH_AUTH_SOCK}" ] || ! ps -p "${SSH_AGENT_PID}" >/dev/null; then
    # Start the ssh agent and store the environment variables in a file
    SSH_AGENT_ENV_DIR="$HOME/.ssh"
    SSH_AGENT_ENV="${SSH_AGENT_ENV_DIR}/ssh-agent.env"

    if [ ! -d "${SSH_AGENT_ENV_DIR}" ]; then mkdir -p "${SSH_AGENT_ENV_DIR}"; fi
    ssh-agent -s >"${SSH_AGENT_ENV}"
    source "${SSH_AGENT_ENV}"
fi

blueman-applet &
