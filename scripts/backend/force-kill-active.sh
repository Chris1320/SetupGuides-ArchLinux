#!/usr/bin/env bash

APPNAME="Hyprland"
URGENCY="normal"
ICON_NAME="window-close"

ACTIVE_WINDOW_CLASS=$(hyprctl activewindow -j | jq -r .class)
ACTIVE_WINDOW_NAME=$(hyprctl activewindow -j | jq -r .title)
ACTIVE_WINDOW_PID=$(hyprctl activewindow -j | jq -r .pid)

kill -9 "$ACTIVE_WINDOW_PID"
dunstify \
    -a $APPNAME \
    -u $URGENCY \
    -i $ICON_NAME \
    "Forcibly killed $ACTIVE_WINDOW_NAME" \
    "from $ACTIVE_WINDOW_CLASS (pid $ACTIVE_WINDOW_PID)"
