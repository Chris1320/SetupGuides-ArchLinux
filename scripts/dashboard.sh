#!/usr/bin/env bash

TEMP_FILE="$HOME/.cache/dashboard.eww.tmp"
DASHBOARD_CONFIG_PATH="$HOME/.config/eww/dashboard"

open_eww() {
    touch "$TEMP_FILE"
    eww -c "${DASHBOARD_CONFIG_PATH}" open dashboard
}
close_eww() {
    eww -c "${DASHBOARD_CONFIG_PATH}" close-all
    rm "$TEMP_FILE"
}

# Check if eww daemon is already running
if ! pgrep -x "eww" > /dev/null; then
    eww daemon
    sleep 1  # Wait for eww daemon to start
fi

case "$1" in
    open) open_eww;;
    close) close_eww;;
esac

if [[ ! -f "$TEMP_FILE" ]]; then open_eww
else close_eww
fi
