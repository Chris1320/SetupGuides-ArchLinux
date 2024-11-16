#!/usr/bin/env bash

# This script is used to lock the screen with hyprlock,
# with an option to enable the privacy lockscreen.

ROFI_THEME="$HOME/.config/rofi/config/confirm.rasi"
PRIVACY_CONFIG_PATH="$HOME/.config/hypr/hyprlock_privacy.conf"
QUESTION="Enable privacy lockscreen?"

yes=""
no=""

if [[ "$1" == "--private" ]]; then
    lock_opaque="$yes"
elif [[ "$1" == "--no-private" ]]; then
    lock_opaque="$no"
else
    lock_opaque=$(printf "%s\n%s" "$no" "$yes" | rofi -dmenu -i -p "$QUESTION" -theme "$ROFI_THEME")
    # Do nothing if the user cancels the prompt.
    if [ -z "$lock_opaque" ]; then
        exit 1
    fi
fi

sleep 1
if [ "$lock_opaque" = "$yes" ]; then
    hyprlock -c "$PRIVACY_CONFIG_PATH" &
else
    hyprlock & # Use the default config
fi
