#!/usr/bin/env bash

rofi \
    -modes "drun,run,window,ssh" \
    -show drun \
    -drun-match-fields all \
    -no-drun-show-actions \
    -show-icons \
    -icon-theme "Papirus" \
    -window-format "{w} {c} — {t}" \
    -scroll-method 1 \
    -terminal kitty \
    -theme "$HOME/.config/rofi/config/launcher.rasi"
