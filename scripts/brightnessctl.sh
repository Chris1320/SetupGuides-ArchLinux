#!/usr/bin/env bash

# You can call this script like this:
# $ ./brightnessctl.sh up
# $ ./brightnessctl.sh down

# Original script:
#   https://github.com/madpro25/dotfiles/blob/main/hypr/scripts/brightness_ctl.sh
#
# Script inspired by these wonderful people:
#   https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
#   https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a


function getBrightness {
    brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}'
}

function sendNotification {
    icon="preferences-system-brightness-lock"
    brightness=$(getBrightness)

    # Send the notification
    dunstify -a "Brightness" -i "$icon" -r 5555 -u low -h "int:value:$brightness" "$1"
}

case $1 in
    up)
        brightnessctl set 5%+
        sendNotification "Brightness has been increased."
        ;;

    down)
        brightnessctl set 5%-
        sendNotification "Brightness has been decreased."
        ;;

    max)
        brightnessctl set 100%
        sendNotification "Brightness has been set to maximum."
        ;;

    blank)
        brightnessctl set 0%
        sendNotification "Brightness has been set to minimum."
        ;;
esac
