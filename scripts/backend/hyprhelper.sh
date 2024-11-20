#!/usr/bin/env bash

SCRIPT_NOTIF_PID=9124

if [[ -z "$1" ]]; then
    exit 1
fi

show_notification() {
    # FIXME: replace with actual icon
    dunstify \
        -a "Hyprland" \
        -u low \
        -i "virtual-desktops" \
        -r "$SCRIPT_NOTIF_PID" \
        "$1"
}

case "$1" in
"pin")
    ac=$(hyprctl activewindow -j)
    hyprctl dispatch pin
    if [[ "$(echo "$ac" | jq -r '.pinned')" == "true" ]]; then
        show_notification "Unpinned $(echo "$ac" | jq -r '.title') ($(echo "$ac" | jq -r '.pid'))"
    else
        show_notification "Pinned $(echo "$ac" | jq -r '.title') ($(echo "$ac" | jq -r '.pid'))"
    fi
    ;;
*)
    exit 2
    ;;
esac
