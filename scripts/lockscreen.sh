#!/usr/bin/env bash

ROFI_THEME="$HOME/.config/rofi/config/confirm.rasi"
QUESTION="Enable Privacy lockscreen?"

yes=""
no=""

if [[ "$1" == "--private" ]]; then
    lock_opaque="$yes"
elif [[ "$1" == "--no-private" ]]; then
    lock_opaque="$no"
else
    lock_opaque=$(printf "%s\n%s" "$no" "$yes" | rofi -dmenu -i -p "$QUESTION" -theme "$ROFI_THEME")
fi

sleep 1
if [ "$lock_opaque" = "$yes" ]; then
    swaylock -C ~/.config/swaylock/privacy.config
else
    swaylock # Use the default config
fi
