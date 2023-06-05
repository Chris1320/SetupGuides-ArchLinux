#!/usr/bin/env bash

# Check the value of MPD_PLAYER_STATE.

if [[ $MPD_PLAYER_STATE == "play" ]]; then
    notify-send -a "Music" -r 27072 -u low " Now Playing" "$(mpc --format '%title% \n%artist% - %album%' current)"

elif [[ $MPD_PLAYER_STATE == "pause" ]]; then
    notify-send -a "Music" -r 27072 -u low " Paused"

elif [[ $MPD_PLAYER_STATE == "stop" ]]; then
    notify-send -a "Music" -r 27072 -u low " Stopped"

fi
