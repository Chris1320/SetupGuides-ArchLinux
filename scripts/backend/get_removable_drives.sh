#!/usr/bin/env bash

# TODO: add support for disk operations and locking/unlocking of encrypted partitions.

DELAY=1
SCRIPT_NOTIFICATION_ID=91622
INCLUDE_ONLY="/run/media/$(whoami)" # Include only partitions mounted under this directory.
ROFI_THEME="$HOME/.config/rofi/config/disks.rasi"

# Get a list of removable disks in JSON format via lsblk.
get_removable_drives() {
    lsblk -aJo 'PATH' -Q 'TRAN=="usb" && SIZE>0' | jq '.blockdevices'
}

# Get the number of removable disks via lsblk.
get_removable_drives_quantity() {
    get_removable_drives | jq length
}

# Get a list of disks and partitions in JSON format.
get_removable_partitions() {
    columns='NAME,LABEL,MOUNTPOINT,PATH,RO,FSTYPE,FSSIZE'
    # only include partitions under disks listed by get_removable_drives
    rem_drives=$(get_removable_drives | jq -r 'map(.path)')
    lsblk -aJo "$columns" -Q "type=='part'" |
        jq \
            --argjson rem_drives "$rem_drives" \
            '.blockdevices[] | select(.path | startswith($rem_drives[]))'
}

# Open the parition directory using the default file manager.
view_partition_contents() {
    dunstify -a "Disks" -u low -i "drive-harddisk-usb-symbolic" -r "$SCRIPT_NOTIFICATION_ID" "Opening $part_label's contents"
    xdg-open "$part_path" &>/dev/null &
}

# Mount a partition using udisksctl.
# $1: Partition Label
# $2: Partition Name
# $3: Partition Path
# $4: "true" if read-write, otherwise read-only
# $5: If "suppress", do not display a notification.
mount_partition() {
    if [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ] && [ -n "$4" ]; then
        if [ "$4" == "true" ]; then
            [ "$5" != "suppress" ] && dunstify -a "Disks" -u normal -i "udiskie-mount" -r "$SCRIPT_NOTIFICATION_ID" "Mounting $1 ($2) as read-write"
            if ! udisksctl mount -b "$3"; then
                [ "$5" != "suppress" ] && dunstify -a "Disks" -u critical -i "udiskie-mount" -r "$SCRIPT_NOTIFICATION_ID" "Failed to mount $1 ($2)"
                exit 1
            fi
        else
            [ "$5" != "suppress" ] && dunstify -a "Disks" -u normal -i "udiskie-mount" -r "$SCRIPT_NOTIFICATION_ID" "Mounting $1 ($2) as read-only"
            if ! udisksctl mount -o ro -b "$3"; then
                [ "$5" != "suppress" ] && dunstify -a "Disks" -u critical -i "udiskie-mount" -r "$SCRIPT_NOTIFICATION_ID" "Failed to mount $1 ($2)"
                exit 1
            fi
        fi
    fi
}

# Unmount a partition using udisksctl.
# $1: Partition Label
# $2: Partition Name
# $3: Partition Path
# $4: "true" if forcibly unmount, otherwise regular unmount.
# $5: If "suppress", do not display a notification.
unmount_partition() {
    if [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ] && [ -n "$4" ]; then
        if [ "$5" == "true" ]; then
            [ "$5" != "suppress" ] && dunstify -a "Disks" -u normal -i "udiskie-unmount" -r "$SCRIPT_NOTIFICATION_ID" "Forcibly unmounting $1 ($2)"
            if ! udisksctl unmount --force -b "$3"; then
                [ "$5" != "suppress" ] && dunstify -a "Disks" -u critical -i "udiskie-unmount" -r "$SCRIPT_NOTIFICATION_ID" "Failed to forcibly unmount $1 ($2)"
                exit 1
            fi
        else
            [ "$5" != "suppress" ] && dunstify -a "Disks" -u normal -i "udiskie-unmount" -r "$SCRIPT_NOTIFICATION_ID" "Unmounting $1 ($2)"
            if ! udisksctl unmount -b "$3"; then
                [ "$5" != "suppress" ] && dunstify -a "Disks" -u critical -i "udiskie-unmount" -r "$SCRIPT_NOTIFICATION_ID" "Failed to unmount $1 ($2)"
                exit 1
            fi
        fi
    fi
}

# Re-mount a partition as read-write or read-only.
# $1: Partition Label
# $2: Partition Name
# $3: Partition Path
# $4: "true" if read-write, otherwise read-only
remount() {
    if [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ] && [ -n "$4" ]; then
        if [ "$4" == "true" ]; then
            dunstify -a "Disks" -u normal -i "drive-removable-media-usb-pendrive" -r "$SCRIPT_NOTIFICATION_ID" "Re-mounting $1 ($2) as read-write"
            unmount_partition "$1" "$2" "$3" "false" "suppress"
            mount_partition "$1" "$2" "$3" "true" "suppress"
        else
            dunstify -a "Disks" -u normal -i "drive-removable-media-usb-pendrive" -r "$SCRIPT_NOTIFICATION_ID" "Re-mounting $1 ($2) as read-only"
            unmount_partition "$1" "$2" "$3" "false" "suppress"
            mount_partition "$1" "$2" "$3" "false" "suppress"
        fi
    fi
}

# If no arguments are passed,
# exit based on the number of removable disks.
if [[ -z "$1" ]]; then
    # If there are no removable disks, return 1.
    [ "$(get_removable_drives_quantity)" -le 0 ] && exit 1 || exit 0
fi

case "$1" in
"--monitor")
    # Print the number of removable disks every $DELAY seconds.
    while true; do
        q=$(get_removable_drives_quantity)
        [ "$q" -le 0 ] && echo "" || echo "$q"
        sleep $DELAY
    done
    ;;

"--rofi")
    [ "$DRIVE_DEBUG_MODE" == "true" ] && printf \
        "Delay: \"%s\"\nScript Notification ID: \"%s\"\nInclude Only: \"%s\"\nRofi Theme: \"%s\"\n" \
        "$DELAY" \
        "$SCRIPT_NOTIFICATION_ID" \
        "$INCLUDE_ONLY" \
        "$ROFI_THEME"

    devs_json=$(get_removable_partitions)

    # Create a list of removable partitions.
    partitions=()
    for ((i = 0; i < $(echo "$devs_json" | jq -s length); i++)); do
        partition=$(echo "$devs_json" | jq -s ".[$i]")

        # Check if the partition is mounted.
        if [ "$(echo "$partition" | jq -r '.mountpoint')" == "null" ]; then
            partitions+=("$(echo "$partition" | jq -r '"  [" + .name + "] " + (.label // "Unnamed Partition") + " (" + .fstype + " @ " + .path + ")"')")
        else
            # Only include partitions mounted under the INCLUDE_ONLY directory.
            if [[ "$(echo "$partition" | jq -r '.mountpoint')" == "$INCLUDE_ONLY"* ]]; then
                partitions+=("$(echo "$partition" | jq -r '" [" + .name + "] " + (.fssize // "") + " " + (.label // "Unnamed Partition") + " (" + if .ro == true then "Read-only " else "" end + .fstype + " @ " + .mountpoint + ")"')")
            fi
        fi
    done

    if [ ${#partitions[@]} -eq 0 ]; then
        dunstify -a "Disks" -u low -i "drive-removable-media-usb-pendrive" -r "$SCRIPT_NOTIFICATION_ID" "No removable partitions found"
        exit 2
    fi

    # Ask the user to select a partition.
    selection=$(printf "%s\n" "${partitions[@]}" | rofi -dmenu -i -theme "$ROFI_THEME")
    if [ -z "$selection" ]; then
        exit 1
    fi

    [ "$DRIVE_DEBUG_MODE" == "true" ] && printf "Selected: \"%s\"\n" "$selection"
    if [[ $selection == " "* ]]; then
        selection=${selection//' '/''}
        # nightmare nightmare nightmare nightmare nightmare nightmare nightmare nightmare nightmare nightmare
        part_name=$(echo "$selection" | awk '{print $1}' | tr -d '[]')
        part_path=$(echo "$selection" | awk -F '@' '{print $2}' | awk -F ')' '{print $1}' | sed 's/^ *//;s/ *$//')
        part_info=$(echo "$devs_json" | jq -s "map(select(.name == \"$part_name\" and .mountpoint == \"$part_path\")) | .[0]")
        part_label=$(echo "$part_info" | jq -r '.label')

        [ "$DRIVE_DEBUG_MODE" == "true" ] && printf "Name: \"%s\"\nLabel: \"%s\"\nPath: \"%s\"\n%s\n" "$part_name" "$part_label" "$part_path" "$part_info"
        available_operations=(
            "View $part_label's contents"
            "Unmount $part_label ($part_name)"
        )
        if [ "$(echo "$part_info" | jq -r '.ro')" == "false" ]; then
            available_operations+=("Re-mount $part_label ($part_name) as read-only")
        else
            available_operations+=("Re-mount $part_label ($part_name) as read-write")
        fi

        operation=$(printf "%s\n" "${available_operations[@]}" | rofi -dmenu -i -theme "$ROFI_THEME")
        case "$operation" in
        "View $part_label's contents")
            view_partition_contents
            ;;
        "Unmount $part_label ($part_name)")
            unmount_partition "$part_label" "$part_name" "$(echo "$part_info" | jq -r '.path')" "false"
            ;;
        "Forcibly unmount $part_label ($part_name)")
            unmount_partition "$part_label" "$part_name" "$(echo "$part_info" | jq -r '.path')" "true"
            ;;
        "Re-mount $part_label ($part_name) as read-only")
            remount "$part_label" "$part_name" "$(echo "$part_info" | jq -r '.path')" "false"
            ;;
        "Re-mount $part_label ($part_name) as read-write")
            remount "$part_label" "$part_name" "$(echo "$part_info" | jq -r '.path')" "true"
            ;;
        *) ;;
        esac
    else
        # still nightmare still nightmare still nightmare still nightmare still nightmare
        part_name=$(echo "$selection" | awk '{print $1}' | tr -d '[]')
        part_path=$(echo "$selection" | awk -F '@' '{print $2}' | awk -F ')' '{print $1}' | sed 's/^ *//;s/ *$//')
        part_info=$(echo "$devs_json" | jq -s "map(select(.name == \"$part_name\" and .path == \"$part_path\")) | .[0]")
        part_label=$(echo "$part_info" | jq -r '.label')

        [ "$DRIVE_DEBUG_MODE" == "true" ] && printf "Name: \"%s\"\nLabel: \"%s\"\nPath: \"%s\"\n%s\n" "$part_name" "$part_label" "$part_path" "$part_info"
        available_operations=(
            "Mount $part_label ($part_name) as read-write"
            "Mount $part_label ($part_name) as read-only"
        )

        operation=$(printf "%s\n" "${available_operations[@]}" | rofi -dmenu -i -theme "$ROFI_THEME")
        case "$operation" in
        "Mount $part_label ($part_name) as read-write")
            mount_partition "$part_label" "$part_name" "$part_path" "true"
            ;;
        "Mount $part_label ($part_name) as read-only")
            mount_partition "$part_label" "$part_name" "$part_path" "false"
            ;;
        *) ;;
        esac
    fi
    ;;
*) ;;
esac
