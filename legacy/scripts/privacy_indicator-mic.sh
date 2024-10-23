#!/usr/bin/env bash

# Inspired by this YouTube video:
# https://www.youtube.com/watch?v=qG7ZotvRN4s

# This script is used to indicate whether the microphone is in use.
# returns 0 as exit code if there's no process using the microphone, Otherwise returns 1.
if [ -z "$(fuser /dev/snd/*c -m 2>/dev/null | tr -d ' ' | cut -d: -f2)" ]; then
    exit 0
else
    exit 1
fi
