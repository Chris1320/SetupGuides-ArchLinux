#!/usr/bin/env bash

ROFI_THEME="$HOME/.config/rofi/config/confirm.rasi"
QUESTION="Enable Privacy lockscreen?"

yes=""
no=""

lock_opaque=$(printf "%s\n%s" "$no" "$yes" | rofi -dmenu -i -p "$QUESTION" -theme "$ROFI_THEME")

sleep 1
if [ "$lock_opaque" = "$yes" ]; then
    swaylock -C ~/.config/swaylock/privacy.config
else
    swaylock  # Use the default config
fi

