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

getCursor() { if [ "$1" = true ]; then echo "-c"; fi }

grabScreen() {
    # Get screen, annotate, and copy to clipboard.
    # :param $1 bool: show cursor

    cursor_cmd=$(getCursor "$1")
    grim -t $FORMAT $cursor_cmd - | swappy -f - -o - | wl-copy
}

grabWindow() {
    # Get window, annotate, and copy to clipboard.
    # :param $1 bool: show cursor

    cursor_cmd=$(getCursor "$1")
    grim -t $FORMAT $cursor_cmd -g "$(getActiveWindowGeometry)" - | swappy -f - -o - | wl-copy
}

grabSelection() {
    # Get selection, grab area, annotate, and copy to clipboard.
    # :param $1 bool: show cursor
    cursor_cmd=$(getCursor "$1")
    grim -t $FORMAT $cursor_cmd -g "$(slurp)" - | swappy -f - -o - | wl-copy
}

if [ "$1" = "screen" ]; then
    if [ "$2" = "show-cursor" ]; then
        show_cursor=true
    else
        show_cursor=false
    fi
    grabScreen "$show_cursor"

elif [ "$1" = "window" ]; then
    if [ "$2" = "show-cursor" ]; then
        show_cursor=true
    else
        show_cursor=false
    fi
    grabWindow "$show_cursor"

elif [ "$1" = "selection" ]; then
    if [ "$2" = "show-cursor" ]; then
        show_cursor=true
    else
        show_cursor=false
    fi
    grabSelection "$show_cursor"

else
    echo "Usage: screenshot.sh [screen|window|selection] [show-cursor]"
fi
