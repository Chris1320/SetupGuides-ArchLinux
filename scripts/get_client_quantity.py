#!/usr/bin/env python3

# This script is used to get the number of clients Hyprland has.
# This is how it should be used:
#
# $ ~/.config/scripts/get_client_quantity.py

import sys
import json
import subprocess


def main() -> int:
    try:
        quantity = len(json.loads(subprocess.getoutput("hyprctl clients -j")))
        if "--notify" in sys.argv:
            subprocess.run(
                [
                    "notify-send",
                    "-a", "Hyprland",
                    "-u", "low",
                    "-i", "virtual-desktops",
                    f"{quantity} clients connected."
                ]
            )

        print(quantity)

    except Exception as e:
        # If the JSON data could not be parsed, return 1.
        print("Error:", e)
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
