#!/usr/bin/env bash

set -e
export CURSOR=""
export CURSORSIZE=""

ls /usr/share/icons/ && \
    CURSORTHEME=$(find /usr/share/icons -maxdepth 1 -type d | cut -d '/' -f 5 | sort | tail -n +2 | rofi -dmenu -no-custom -i -p "Select cursor theme" -mesg "Default: $XCURSOR_THEME")

export CURSORSIZE=$(rofi -dmenu -p "Set cursor size" -mesg "Default: $XCURSOR_SIZE")
export CURSOR=$CURSORTHEME

if [[ -z "$CURSOR" || "$CURSOR" == " " ]]; then
    export CURSOR=$XCURSOR_THEME
fi

if [[ -z "$CURSORSIZE" || "$CURSORSIZE" == " " ]]; then
    export CURSORSIZE=$XCURSOR_SIZE
fi

# check if ~/.icons/default/index.theme file exists. If not, create the path.
if [[ ! -f "$HOME/.icons/default/index.theme" ]]; then
    mkdir -p "$HOME/.icons/default"
    touch "$HOME/.icons/default/index.theme"
fi

echo -e "[Icon Theme]\nInherits=$CURSOR" > ~/.icons/default/index.theme
bash "$HOME/.config/scripts/update-gsettings.sh"
