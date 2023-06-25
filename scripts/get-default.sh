#!/usr/bin/env bash

[[ -z "$1" ]] && echo "Usage: $0 <file>" && exit 1  # Check if there is $1.
[[ ! -f "$1" ]] && echo "File \"$1\" not found." && exit 1  # Check if the file ($1) exists.

mimetype=$(xdg-mime query filetype "$1")
default=$(xdg-mime query default "$mimetype")

echo "MIME Type:   $mimetype"

# Check if $default is empty.
if [[ -z "$default" ]]; then
    echo "Default App: None"
else
    echo "Default App: $default"
fi
exit 0
