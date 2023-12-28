#!/usr/bin/env bash

APPNAME="Hyprland"
URGENCY="normal"
ICON_NAME="window-close"

ACTIVE_WINDOW_CLASS=$(hyprctl activewindow -j | jq -r .class)
ACTIVE_WINDOW_NAME=$(hyprctl activewindow -j | jq -r .title)
ACTIVE_WINDOW_PID=$(hyprctl activewindow -j | jq -r .pid)

sendNotification() {
    dunstify \
        -a $APPNAME \
        -u $URGENCY \
        -i $ICON_NAME \
        "$1" \
        "$2"
}

if [ "$ACTIVE_WINDOW_PID" == "null" ]; then
    sendNotification "No active window to kill"
    exit 1
fi

kill -9 "$ACTIVE_WINDOW_PID"
sendNotification \
    "Forcibly killed $ACTIVE_WINDOW_NAME" \
    "from $ACTIVE_WINDOW_CLASS (pid $ACTIVE_WINDOW_PID)"
exit 0
