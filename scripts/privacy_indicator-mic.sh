#!/usr/bin/env bash

# Inspired by this YouTube video:
# https://www.youtube.com/watch?v=qG7ZotvRN4s

# This script is used to indicate whether the microphone is in use.
if grep owner_pid /proc/asound/card*/pcm*/sub*/status > /dev/null 2>&1; then
    exit 0
fi

exit 1
