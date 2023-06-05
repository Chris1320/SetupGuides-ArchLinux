#!/usr/bin/env bash

music_dir="$HOME/Music"
previewdir="$HOME/.config/ncmpcpp/previews"

filename="$(mpc --format "$music_dir"/%file% current)"
previewname="$previewdir/$(mpc --format %album% current | base64).png"

[ -e "$previewname" ] || ffmpeg -y -i "$filename" -an -vf scale=128:128 "$previewname" > /dev/null 2>&1

notify-send -a "Now Playing" -r 27072 "$(mpc --format '%title%\n%artist%\n%album%' current)" -i "$previewname"
