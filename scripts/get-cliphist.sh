#!/usr/bin/env bash

ROFI_THEME="$HOME/.config/rofi/config/cliphist.rasi"

sendNotification() {
    notify-send \
        --app-name="Clipboard History" \
        --urgency=low \
        --icon=clipboard \
        "$1"
}

selection=$(cliphist list | rofi -dmenu -no-custom -i -scroll-method 1 -theme "$ROFI_THEME")

if [[ -z "$selection" ]]; then
    sendNotification "No selection copied."
else
    echo "$selection" | cliphist decode | wl-copy
    sendNotification "Selection copied to clipboard."
fi
