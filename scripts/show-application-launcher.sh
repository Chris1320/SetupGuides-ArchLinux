#!/usr/bin/env bash

rofi \
    -modes "drun,run,ssh" \
    -show drun \
    -drun-match-fields all \
    -no-drun-show-actions \
    -show-icons \
    -icon-theme "Papirus" \
    -scroll-method 1 \
    -terminal kitty \
    -theme "$HOME/.config/rofi/config/launcher.rasi"
