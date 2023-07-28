#!/usr/bin/env bash

MODE="window"

"$HOME/.config/scripts/get_client_quantity.py" --notify

if [[ "$1" == "--workspace" ]]; then
    MODE="workspace"
fi

rofi \
    -modes "window,workspace:$HOME/.config/scripts/workspace_switcher.sh" \
    -show $MODE \
    -show-icons \
    -icon-theme "Papirus" \
    -window-format "{w} {c} — {t}" \
    -scroll-method 1 \
    -terminal kitty \
    -theme "$HOME/.config/rofi/config/launcher.rasi"
