#!/usr/bin/env bash

# This script is used to change the avatar of the current user.
# It takes one argument, which is the path to the image file to use as the avatar.

FACE_PATH="$HOME/.face"

if [ ! -f "$1" ]; then
    echo "Error: $1 is not a file."
    exit 1
fi

cp "$1" "$FACE_PATH"

# Create symlinks.
ln -sT "$FACE_PATH" "$HOME/.face.icon"
ln -sT "$FACE_PATH" "/usr/share/sddm/faces/$USER.face.icon"
