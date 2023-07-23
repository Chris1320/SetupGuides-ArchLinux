#!/usr/bin/env bash

rofi \
    -modes "window,workspace:$HOME/.config/scripts/workspace_switcher.sh" \
    -show window \
    -show-icons \
    -icon-theme "Papirus" \
    -window-format "{w} {c} — {t}" \
    -scroll-method 1 \
    -terminal kitty \
    -theme "$HOME/.config/rofi/config/launcher.rasi"
