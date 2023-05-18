#!/usr/bin/env bash

# If $1 is on, turn rfkill on, otherwise turn it off
if [[ $1 == "on" ]]; then
    rfkill block wifi
    rfkill block bluetooth
    dunstify -a "Airplane Mode" -u low -t 2000 -i airplane-mode "Airplane mode has been turned on."
elif [[ $1 == "off" ]]; then
    rfkill unblock wifi
    rfkill unblock bluetooth
    dunstify -a "Airplane Mode" -u low -t 2000 -i airplane-mode "Airplane mode has been turned off."
else
    echo "Usage: airplane_mode.sh [on|off]"
fi
