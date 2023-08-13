#!/usr/bin/env bash

TEMP_FILE="$HOME/.cache/dashboard.eww.tmp"
DASHBOARD_CONFIG_PATH="$HOME/.config/eww/dashboard"

# Check if eww daemon is already running
if ! pgrep -x "eww" > /dev/null; then
    eww daemon
    sleep 1  # Wait for eww daemon to start
fi

## Launch or close widgets accordingly
if [[ ! -f "$TEMP_FILE" ]]; then
    eww -c "${DASHBOARD_CONFIG_PATH}" open dashboard

else
    eww -c "${DASHBOARD_CONFIG_PATH}" close-all
    rm "$TEMP_FILE"
fi
