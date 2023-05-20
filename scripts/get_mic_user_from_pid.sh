#!/usr/bin/env bash

# Get the PID of the process using the microphone.
USER_PID=$(fuser /dev/snd/*c -m 2>/dev/null | tr -d ' ' | cut -d: -f2)

#echo "User PID: $USER_PID"

if [ -z "$USER_PID" ]; then
    echo "No process is using the microphone."
    exit 1
else
    # Get the process name using the user PID.
    # FIXME: I am currently using Pipewire and this command
    # always show `pipewire` as the process that is using the mic.
    ps -p "$USER_PID" -o "comm="
    exit 0
fi
