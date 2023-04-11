#!/usr/bin/env bash

# Inspired by this YouTube video:
# https://www.youtube.com/watch?v=qG7ZotvRN4s

PID=$(fuser /dev/video0)

# check if there are any numbers in PID ending with the letter m.
# If there are any numbers ending with the letter m, then the camera is in use.

if [[ $PID =~ [0-9]+m ]]; then
    exit 0
fi

exit 1
