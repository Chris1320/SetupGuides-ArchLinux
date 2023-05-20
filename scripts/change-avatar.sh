#!/usr/bin/env bash

# This script is used to change the avatar of the current user.
# It takes one argument, which is the path to the image file to use as the avatar.

FACE_PATH="$HOME/.face"

if [ -z "$1" ]; then
    echo "Error: no file provided."
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: $1 is not a file."
    exit 1
fi

cp "$1" "$FACE_PATH"

# Create symlinks.
ln -sfT "$FACE_PATH" "$HOME/.face.icon"
sudo ln -sfT "$FACE_PATH" "/usr/share/sddm/faces/$USER.face.icon"
