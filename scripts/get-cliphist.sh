#!/usr/bin/env bash

sendNotification() {
    notify-send \
        --app-name="Clipboard History" \
        --urgency=low \
        --icon=clipboard \
        "$1"
}

selection=$(cliphist list | rofi -dmenu -no-custom -i -p "Clipboard" -location 3)

if [[ -z "$selection" ]]; then
    sendNotification "No selection copied."
else
    echo "$selection" | cliphist decode | wl-copy
    sendNotification "Selection copied to clipboard."
fi
