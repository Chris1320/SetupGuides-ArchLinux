#!/usr/bin/env bash

FONT="Cantarell 11"
FONT_MONO="JetBrainsMono Nerd Font Mono 10"
icon_theme="Catppuccin-Mocha-Teal-Cursors"
gtk_theme="Catppuccin-Mocha-Standard-Teal-Dark"

if [[ -z "$CURSOR" || "$CURSOR" == " " ]]; then
    export CURSOR=$XCURSOR_THEME
fi

if [[ -z "$CURSORSIZE" || "$CURSORSIZE" == " " ]]; then
    export CURSORSIZE=$XCURSOR_SIZE
fi

gsettings set org.gnome.desktop.interface font-name "$FONT" &&
    gsettings set org.gnome.desktop.interface document-font-name "$FONT" &&
    gsettings set org.gnome.desktop.interface monospace-font-name "$FONT_MONO" &&
    gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR" &&
    gsettings set org.gnome.desktop.interface icon-theme $icon_theme &&
    gsettings set org.gnome.desktop.interface gtk-theme $gtk_theme &&
    gsettings set org.gnome.desktop.interface cursor-size "$CURSORSIZE" &&
    hyprctl setcursor "$CURSOR" "$CURSORSIZE" &&
    export XCURSOR_THEME="$CURSOR" &&
    export XCURSOR_SIZE="$CURSORSIZE"

notify-send -a "update-gsettings.sh" "Theme settings updated."
