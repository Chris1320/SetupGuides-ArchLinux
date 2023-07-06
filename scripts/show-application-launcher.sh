#!/usr/bin/env bash

rofi \
    -modes "drun,run" \
    -show drun \
    -show-icons \
    -icon-theme "Papirus" \
    -scroll-method 1 \
    -sidebar-mode \
    -terminal kitty \
    -display-drun "Applications" \
    -display-run "Executables"
