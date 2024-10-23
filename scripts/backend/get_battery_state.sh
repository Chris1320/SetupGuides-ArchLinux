#!/usr/bin/env bash

# Original source:
# https://github.com/end-4/dots-hyprland/blob/main/.config/hypr/hyprlock/status.sh

enable_battery=false
battery_charging=false

# Check battery availability
for battery in /sys/class/power_supply/*BAT*; do
    if [[ -f "$battery/uevent" ]]; then
        enable_battery=true
        if [[ $(cat /sys/class/power_supply/*/status | head -1) == "Charging" ]]; then
            battery_charging=true
        fi
        break
    fi
done

############# Output #############
if [[ $enable_battery == true ]]; then
    if [[ $battery_charging == true ]]; then
        printf "Charging, "
    fi
    printf "%s" "$(~/.config/scripts/backend/sys_info.sh --bat)"
    if [[ $battery_charging == false ]]; then
        printf " remaining"
    fi
fi

printf '\n'
