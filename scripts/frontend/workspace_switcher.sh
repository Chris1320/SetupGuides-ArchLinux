#!/usr/bin/env bash

# NOTE: Use `window_switcher.sh` instead of this script.
# This is script is used by `window_switcher.sh` to switch workspaces.

getWorkspaces() {
    hyprctl_output=$(hyprctl workspaces)
    # Get only the ID and its name in each line.
    workspaces=$(echo "$hyprctl_output" | grep -E "^workspace ID " | sed -E "s/^workspace ID (-?[0-9]+) \((.*)\) on monitor (.*)/\1 \2/g")
    # align the workspace IDs to the right.
    workspaces_display=$(echo "$workspaces" | awk '{printf "%-10s %s\n", $1, $2}')
    echo "$workspaces_display"
}

if [ -z "$1" ]; then
    getWorkspaces
else
    # Strip the workspace name from the input and get only the ID.
    workspace_id=$(echo "$1" | sed -E "s/^(-?[0-9]+) .*/\1/g")
    hyprctl dispatch workspace "$workspace_id" >/dev/null
fi
