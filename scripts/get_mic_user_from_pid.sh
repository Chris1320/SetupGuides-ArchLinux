#!/usr/bin/env bash

# Get the owner PID.
USER_PID=$(grep owner_pid /proc/asound/card*/pcm*/sub*/status | cut -d: -f3 | tr -d ' ')

if [ -z "$USER_PID" ]; then
    echo "No process is using the microphone."
    exit 1

else
    # Get the process name using the user PID.
    ps -p "$USER_PID" -o user=
    # The command below is for determining the process name:
    # ps -p "$USER_PID" -o comm=
    # This does not currently work lol
    # It's having problems identifying the actual process that
    # uses it, since in my case, it always show "pipewire" as
    # the process.
    exit 0
fi
