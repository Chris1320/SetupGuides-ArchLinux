#!/usr/bin/env bash

# Check the value of MPD_PLAYER_STATE.

if [[ $MPD_PLAYER_STATE == "play" ]]; then
    bash ~/.config/scripts/show-song-info.sh

elif [[ $MPD_PLAYER_STATE == "pause" ]]; then
    notify-send -a "Music" -r 27072 -u low -i "media-playback-pause" "Music paused"

elif [[ $MPD_PLAYER_STATE == "stop" ]]; then
    notify-send -a "Music" -r 27072 -u low -i "media-playback-stopped" "Music stopped"

fi
