#!/usr/bin/env bash

MENU_ROFI_THEME="$HOME/.config/rofi/config/powermenu.rasi"
CONF_ROFI_THEME="$HOME/.config/rofi/config/confirm.rasi"

yes=""
no=""

lock=""
sleep=""
logout=""
restart="󰜉"
poweroff="󰐥"

user_selection=$(printf "%s\n%s\n%s\n%s\n%s\n" "$lock" "$sleep" "$logout" "$restart" "$poweroff" | rofi -dmenu -theme "$MENU_ROFI_THEME")

case "$user_selection" in
"$lock")
    # This script has its own confirmation prompt.
    ~/.config/scripts/frontend/lockscreen.sh
    ;;
"$sleep")
    sleep_confirm=$(printf "%s\n%s" "$yes" "$no" | rofi -dmenu -i -p "Suspend the system?" -theme "$CONF_ROFI_THEME")
    if [ -z "$sleep_confirm" ]; then
        exit 1
    elif [ "$sleep_confirm" = "$yes" ]; then
        ~/.config/scripts/frontend/lockscreen.sh --no-private && systemctl suspend
    fi
    ;;
"$logout")
    logout_confirm=$(printf "%s\n%s" "$yes" "$no" | rofi -dmenu -i -p "Do you really want to log out?" -theme "$CONF_ROFI_THEME")
    if [ -z "$logout_confirm" ]; then
        exit 1
    elif [ "$logout_confirm" = "$yes" ]; then
        hyprctl dispatch exit
    fi
    ;;
"$restart")
    restart_confirm=$(printf "%s\n%s" "$yes" "$no" | rofi -dmenu -i -p "Restart the system?" -theme "$CONF_ROFI_THEME")
    if [ -z "$restart_confirm" ]; then
        exit 1
    elif [ "$restart_confirm" = "$yes" ]; then
        systemctl reboot
    fi
    ;;
"$poweroff")
    poweroff_confirm=$(printf "%s\n%s" "$yes" "$no" | rofi -dmenu -i -p "Shut the system down?" -theme "$CONF_ROFI_THEME")
    if [ -z "$poweroff_confirm" ]; then
        exit 1
    elif [ "$poweroff_confirm" = "$yes" ]; then
        systemctl poweroff
    fi
    ;;
esac
