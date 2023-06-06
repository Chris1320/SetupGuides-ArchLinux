#!/usr/bin/env bash

# Screenshot whole screen, window, or selection.
# Uses grim, slurp, swappy, and wl-clipboard.
#
# Commands:
# - screen
# - window
# - selection

FORMAT="png"
FILENAME="%Y-%m-%d_%H-%M-%S"

getScreenshotPath() {
    echo "$(xdg-user-dir PICTURES)"/Screenshots/"$(date +$FILENAME)".$FORMAT
}

getActiveWindowGeometry() {
    at=$(hyprctl activewindow | grep "at:" | tr -d ' ' | cut -d ':' -f 2)
    size=$(hyprctl activewindow | grep "size:" | tr -d ' ' | cut -d ':' -f 2 | tr ',' 'x')
    echo "$at $size"
}

grabScreen() {
    # Get screen, annotate, and copy to clipboard.
    # :param $1 bool: show cursor

    grim -t $FORMAT -c - | swappy -f - -o - | wl-copy
}

grabWindow() {
    # Get window, annotate, and copy to clipboard.
    # :param $1 bool: show cursor

    grim -t $FORMAT -c -g "$(getActiveWindowGeometry)" - | swappy -f - -o - | wl-copy
}

grabSelection() {
    # Get selection, grab area, annotate, and copy to clipboard.
    # :param $1 bool: show cursor
    grim -t $FORMAT -c -g "$(slurp)" - | swappy -f - -o - | wl-copy
}

if [ "$1" = "screen" ]; then
    grabScreen

elif [ "$1" = "window" ]; then
    grabWindow

elif [ "$1" = "selection" ]; then
    grabSelection

else
    echo "Usage: screenshot.sh [screen|window|selection]"

fi
