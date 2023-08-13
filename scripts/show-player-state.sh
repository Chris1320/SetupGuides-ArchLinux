#!/usr/bin/env bash

if [[ -z "$MPD_PLAYER_STATE" ]]; then MPD_PLAYER_STATE=$(mpc status "%state%"); fi
# play, pause, stop
icons=("" "" "")

if [[ "$1" == "--no-notify" ]]
then no_notify=true
else no_notify=false
fi

# play is from ncmpcpp, playing is from mpc
if [[ $MPD_PLAYER_STATE == "play" ]] || [[ $MPD_PLAYER_STATE == "playing" ]]; then
    if [[ $no_notify == false ]]
    then bash ~/.config/scripts/show-song-info.sh
    else echo "${icons[0]}"
    fi

# pause is from ncmpcpp, paused is from mpc
elif [[ $MPD_PLAYER_STATE == "pause" ]] || [[ $MPD_PLAYER_STATE == "paused" ]]; then
    if [[ $no_notify == false ]]
    then notify-send -a "Music" -r 27072 -u low -i "media-playback-pause" "Music paused"
    else echo "${icons[1]}"
    fi

elif [[ $MPD_PLAYER_STATE == "stop" ]]; then
    if [[ $no_notify == false ]]
    then notify-send -a "Music" -r 27072 -u low -i "media-playback-stopped" "Music stopped"
    else echo "${icons[2]}"
    fi
fi
