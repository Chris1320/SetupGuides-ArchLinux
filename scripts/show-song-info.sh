#!/usr/bin/env bash

music_dir="$HOME/Music"
previewdir="$HOME/.cache/ncmpcpp/previews"
previewsize="1024:1024"  # 1024x1024 pixels (my library usually have 500x500 to 3000x3000 images)

# Create the preview cache directory if it doesn't exist
if [[ ! -d "$previewdir" ]]; then mkdir -p "$previewdir"; fi

# Check if music is playing
if [[ "$(mpc status | grep -o 'playing')" != "playing" ]]; then
    # Show the default image if no music is playing
    if [[ "$1" == "--no-notify" ]]; then
        echo "$HOME/.config/dotfiles_custom/assets/dashboard/default-music.png"
    fi
    exit 1
fi

# Get the current song's filename
filename="$(mpc --format "$music_dir"/%file% current)"
# Get the current song's preview filename
previewname="$previewdir/$(mpc --format '%artist% - %title% (%album%)' current | base64).png"

# Create the preview image if it doesn't exist
[ -e "$previewname" ] || ffmpeg -y -i "$filename" -an -vf scale=$previewsize "$previewname" > /dev/null 2>&1

if [[ "$1" == "--no-notify" ]]; then
    # Only print the preview filename for use in other scripts
    echo "$previewname"
else
    # Send a notification with the preview image by default
    notify-send \
        -a "Now Playing" \
        -r 27072 \
        "$(mpc --format '%title%\n%artist%\n%album%' current)" \
        -i "$previewname"
fi

exit 0
