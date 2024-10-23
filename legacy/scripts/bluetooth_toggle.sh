#!/usr/bin/env bash

# Get the current state of bluetooth
state=$(bluetoothctl show | grep Powered | awk '{ print $2 }')

if [[ $state == 'yes' ]]; then
    bluetoothctl power off
    dunstify -a "Bluetooth" -u low -r 5554 -i bluetooth-offline "Bluetooth has been turned off."
else
    bluetoothctl power on
    dunstify -a "Bluetooth" -u low -r 5554 -i bluetooth-online "Bluetooth has been turned on."
fi
