#!/usr/bin/env bash

VOLUME_INCREMENT=5
VOLUME_MAX=100
VOLUME_MIN=0

function getVolume {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100, $3}'
}

function setVolume {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1"
}

function getVolumeIcon {
    # audio-volume-muted:  Volume muted
    # audio-volume-low:    1% to 35%
    # audio-volume-medium: 35% to 70%
    # audio-volume-high:   70% to 100%
    case $1 in
    0) echo "audio-volume-muted" ;;
    [1-9] | [1-2][0-9] | 3[0-5]) echo "audio-volume-low" ;;
    3[6-9] | [4-6][0-9]) echo "audio-volume-medium" ;;
    7[0-9] | 8[0-9] | 9[0-9] | 100) echo "audio-volume-high" ;;
    esac
}

function sendNotification {
    icon=$(getVolumeIcon "$1")
    dunstify -a "Volume" -i "$icon" -r 5612 -u low -h "int:value:$1" "$2"
}

case $1 in
up)
    current_volume=$(getVolume | awk '{print $1}')
    if [ $((current_volume + VOLUME_INCREMENT)) -ge $VOLUME_MAX ]; then
        setVolume $VOLUME_MAX%
        sendNotification "$VOLUME_MAX" "Volume is already at maximum."

    else
        setVolume $VOLUME_INCREMENT%+
        sendNotification "$(getVolume)" "Volume has been increased."
    fi
    ;;

down)
    current_volume=$(getVolume | awk '{print $1}')
    if [ $((current_volume - VOLUME_INCREMENT)) -le $VOLUME_MIN ]; then
        setVolume $VOLUME_MIN%
        sendNotification "$VOLUME_MIN" "Volume is already at minimum."

    else
        setVolume $VOLUME_INCREMENT%-
        sendNotification "$(getVolume)" "Volume has been decreased."
    fi
    ;;

max)
    setVolume $VOLUME_MAX%
    sendNotification "$(getVolume | awk '{print $1}')" "Volume has been set to maximum."
    ;;

min)
    # I don't know if anyone would use this, but I'm adding it anyway.
    # Why wouldn't you use mute instead?
    setVolume $VOLUME_MIN%
    sendNotification "$VOLUME_MIN" "Volume has been set to minimum."
    ;;

mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    status="$(getVolume)"
    if [ "$(echo "$status" | awk '{print $2}')" = "[MUTED]" ]; then
        sendNotification "0" "Volume has been muted."
    else
        sendNotification "$(echo "$status" | awk '{print $1}')" "Volume has been unmuted."
    fi
    ;;
esac
