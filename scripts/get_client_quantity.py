#!/usr/bin/env python3

# This script is used to get the number of clients Hyprland has.

import sys
import json
import subprocess


IGNORED_WORKSPACES: set[str] = set(("special:keepassxc",))


def countClients(clients: dict) -> tuple[int, int, int]:
    """
    Counts the normal, scratchpad, and hidden clients.
    """

    normal_clients = 0
    hidden_clients = 0
    scratchpad_clients = 0

    for client in clients:
        if client["workspace"]["name"] in IGNORED_WORKSPACES \
            or (not client["mapped"] and client["xwayland"]):
            # Do not count clients in ignored workspaces and
            # all unmapped x11 clients.
            continue

        elif client["workspace"]["name"] == "special:hidden":
            hidden_clients += 1

        elif client["workspace"]["name"] == "special:scratchpad":
            scratchpad_clients += 1

        else:
            normal_clients += 1

    return (normal_clients, scratchpad_clients, hidden_clients)


def getNotificationDescription(quantity: tuple[int, int, int]) -> str:
    # Get the grammar right.
    desc = f"{quantity[0]} client connected." \
        if quantity[0] == 1 \
        else f"{quantity[0]} clients connected."

    # Add the number of scratchpad clients if there are any.
    if quantity[1] != 0:
        desc += f" ({quantity[1]} on scratchpad"
        # Add the number of hidden clients if there are any.
        desc += f", {quantity[2]} hidden)" if quantity[2] != 0 else ")"

    # If there are no scratchpad clients,
    # add the number of hidden clients if there are any.
    elif quantity[2] != 0:
        desc += f" ({quantity[2]} hidden)"

    return desc


def main() -> int:
    try:
        quantity = countClients(
            json.loads(
                subprocess.getoutput("hyprctl clients -j")
            )
        )
        if "--notify" in sys.argv:
            subprocess.run(
                [
                    "notify-send",
                    "-a", "Hyprland",
                    "-u", "low",
                    "-r", "7314",
                    "-i", "virtual-desktops",
                    getNotificationDescription(quantity)
                ]
            )

        print(','.join(map(str, quantity)))  # Also print it to stdout

    except Exception as e:
        # If the JSON data could not be parsed, return 1.
        print("Error:", e)
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
