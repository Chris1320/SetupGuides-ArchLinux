#!/usr/bin/env bash

# I just want to share this to you.
# My brain is not working while writing this script.
# I just let myself type whatever comes to my mind.
#
# I have no idea how this works... But it works.

RESOURCE_MONITOR="btop"
WORKSPACE_NAME="resmon"
CLASS_NAME="custom-resmon"

resmonIsRunning() {
    hyprctl clients | grep -c "$CLASS_NAME"
}

toggleWorkspace() {
    hyprctl dispatch togglespecialworkspace "$WORKSPACE_NAME"
}

if resmonIsRunning; then
    toggleWorkspace
    exit 0
fi

# Hyprland's window rule will move this to the designated workspace
hyprctl dispatch exec "[workspace special:$WORKSPACE_NAME silent]" "kitty --detach --class=$CLASS_NAME \"$RESOURCE_MONITOR\""
toggleWorkspace
