#!/usr/bin/env bash

ROFI_THEME="$HOME/.config/rofi/config/powermenu.rasi"

lock=""
sleep=""
logout=""
restart="󰜉"
poweroff="󰐥"

user_selection=$(printf "%s\n%s\n%s\n%s\n%s\n" "$lock" "$sleep" "$logout" "$restart" "$poweroff" | rofi -dmenu -theme "$ROFI_THEME")

case "$user_selection" in
    "$lock")
        ~/.config/scripts/lockscreen.sh
        ;;
    "$sleep")
        ~/.config/scripts/lockscreen.sh && systemctl suspend
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
    "$restart")
        systemctl reboot
        ;;
    "$poweroff")
        systemctl poweroff
        ;;
esac

