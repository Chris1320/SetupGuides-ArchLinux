#!/usr/bin/env bash

# Screenshot whole screen, window, or selection.
# Uses grim, slurp, swappy, and wl-clipboard.
#
# Commands:
# - screen
# - window
# - selection
# - interactive

FORMAT="png"
FILENAME="%Y-%m-%d_%H-%M-%S"

getScreenshotPath() {
    echo "$(xdg-user-dir PICTURES)"/Screenshots/"$(date +$FILENAME)".$FORMAT
}

getActiveWindowGeometry() {
    window_info=$(hyprctl activewindow)
    at=$(echo "$window_info" | grep "at:" | tr -d ' ' | cut -d ':' -f 2)
    size=$(echo "$window_info" | grep "size:" | tr -d ' ' | cut -d ':' -f 2 | tr ',' 'x')
    echo "$at $size"
}

sendNotification() {
    notify-send \
        --app-name="Screenshot" \
        --urgency=low \
        --icon="$2" \
        "$1"
}

grabScreen() {
    # Get screen, annotate, and copy to clipboard.
    grim -t $FORMAT -c - | swappy -f - -o - | wl-copy
    sendNotification "Copied to clipboard." "gtk-fullscreen"
}

grabWindow() {
    # Get window, annotate, and copy to clipboard.
    grim -t $FORMAT -c -g "$(getActiveWindowGeometry)" - | swappy -f - -o - | wl-copy
    sendNotification "Window copied to clipboard." "window"
}

grabSelection() {
    # Get selection, grab area, annotate, and copy to clipboard.
    grim -t $FORMAT -g "$(slurp)" - | swappy -f - -o - | wl-copy
    sendNotification "Region copied to clipboard." "image-crop"
}

showMenu() {
    ROFI_THEME="$HOME/.config/rofi/config/screenshot.rasi"
    OPTION1=" Whole Screen"
    OPTION2=" Active Window"
    OPTION3="󰆞 Specified Region"

    CHOICE=$(printf "%s\n%s\n%s" "$OPTION1" "$OPTION2" "$OPTION3" | rofi -dmenu -no-custom -i -theme "$ROFI_THEME")
    sleep 1
    if [ "$CHOICE" = "$OPTION1" ]; then grabScreen
    elif [ "$CHOICE" = "$OPTION2" ]; then grabWindow
    elif [ "$CHOICE" = "$OPTION3" ]; then grabSelection
    else sendNotification "Aborted." "cancel"
    fi
}

if [ "$1" = "screen" ]; then grabScreen
elif [ "$1" = "window" ]; then grabWindow
elif [ "$1" = "selection" ]; then grabSelection
elif [ "$1" = "interactive" ]; then showMenu
else echo "Usage: screenshot.sh [screen|window|selection|interactive]"
fi
