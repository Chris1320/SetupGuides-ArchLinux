#!/usr/bin/env bash

# return the number of the active workspace.

# ? Old command:
# $ hyprctl activeworkspace | head -n 1 | cut -d ' ' -f 3
#
# This script was previously ran by waybar every one second.
# Because of this, the delay of the waybar module's display
# is 1 second at maximum.
#
# Now, we use an event listener to update the active workspace number.
# We will use `socat` to listen to the socket for this to work.
# ? More information: https://wiki.hyprland.org/IPC/

# Check the event type and update the active workspace
# number if it matched the event name.
#
# :param $1: The Hyprland event received from the socket.
handle() {
    if [[ "$1" =~ ^(workspace>).* ]]; then
        echo "$1" | cut -d '>' -f 3
    fi
}

if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    echo "[E] \$HYPRLAND_INSTANCE_SIGNATURE is unset."
    exit 1
else
    HYPR_SOCKET_PATH="/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
fi

# The script won't echo the workspace number until Hyprland receives a `workspace`
# dispatch event, and relays that event to the socket listeners (this script).
# Therefore, we still have to get the current active workspace without using the socket
# at first run so that the waybar module will be shown immediately on start-up.
hyprctl activeworkspace | head -n 1 | cut -d ' ' -f 3
# Tell socat to listen to the socket.
socat -U - UNIX-CONNECT:"$HYPR_SOCKET_PATH" | while read -r line; do handle "$line"; done
