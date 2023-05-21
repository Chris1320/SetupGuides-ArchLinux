#!/usr/bin/env bash

function getVolume {
    pactl list sinks | \
        grep '^[[:space:]]Volume:' | \
        head -n $(( SINK + 1 )) | \
        tail -n 1 | \
        sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'
}

function getVolumeIcon {
    # audio-volume-muted:  Volume muted
    # audio-volume-low:    1% to 35%
    # audio-volume-medium: 35% to 70%
    # audio-volume-high:   70% to 100%
    case $1 in
        0) echo "audio-volume-muted" ;;
        [1-9]|[1-2][0-9]|3[0-5]) echo "audio-volume-low" ;;
        3[6-9]|[4-6][0-9]) echo "audio-volume-medium" ;;
        7[0-9]|8[0-9]|9[0-9]|100) echo "audio-volume-high" ;;
    esac
}

function sendNotification {
    icon=$(getVolumeIcon "$1")
    dunstify -a "Volume" -i "$icon" -r 5612 -u low -h "int:value:$1" "$2"
}

case $1 in
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        sendNotification "$(getVolume)" "Volume has been increased."
        ;;

    down)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        sendNotification "$(getVolume)" "Volume has been decreased."
        ;;

    max)
        pactl set-sink-volume @DEFAULT_SINK@ 100%
        sendNotification "$(getVolume)" "Volume has been set to maximum."
        ;;

    deafen)
        # I don't know if anyone would use this, but I'm adding it anyway.
        # Why wouldn't you use mute instead?
        pactl set-sink-volume @DEFAULT_SINK@ 0%
        sendNotification "0" "Volume has been set to minimum."
        ;;

    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        if [ "$(pactl get-sink-mute @DEFAULT_SINK@)" = "Mute: yes" ]; then
            # Pass 0 instead of $(getVolume) because the volume value is
            # still unchanged, just muted.
            sendNotification "0" "Volume has been muted."
        else
            sendNotification "$(getVolume)" "Volume has been unmuted."
        fi
        ;;
esac
