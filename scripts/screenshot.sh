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
    grim -t $FORMAT -c - | swappy -f - -o - | wl-copy
}

grabWindow() {
    # Get window, annotate, and copy to clipboard.
    grim -t $FORMAT -c -g "$(getActiveWindowGeometry)" - | swappy -f - -o - | wl-copy
}

grabSelection() {
    # Get selection, grab area, annotate, and copy to clipboard.
    grim -t $FORMAT -g "$(slurp)" - | swappy -f - -o - | wl-copy
}

showMenu() {
    PROMPT="Select a screenshot mode"
    OPTION1="Take a screenshot of the whole screen"
    OPTION2="Take a screenshot of the active window"
    OPTION3="Take a screenshot of a specified region"

    CHOICE=$(printf "%s\n%s\n%s" "$OPTION1" "$OPTION2" "$OPTION3" | wofi --show=dmenu --prompt="$PROMPT" -i)
    sleep 1
    if [ "$CHOICE" = "$OPTION1" ]; then grabScreen
    elif [ "$CHOICE" = "$OPTION2" ]; then grabWindow
    elif [ "$CHOICE" = "$OPTION3" ]; then grabSelection
    fi
}

if [ "$1" = "screen" ]; then grabScreen
elif [ "$1" = "window" ]; then grabWindow
elif [ "$1" = "selection" ]; then grabSelection
elif [ "$1" = "interactive" ]; then showMenu
else echo "Usage: screenshot.sh [screen|window|selection]"
fi
