#!/usr/bin/env bash

# Ask the user for default applications for some MIME types.

# Ask the user for the default application.
# $1: MIME type
# $2: Description
# $3: Suggested application
function askDefaultApplication() {
    apps_dir="/usr/share/applications"

    while true; do
        echo "=================================================="
        echo
        read -p "$2 (e.g. $3): " application

        # Find the application's `.desktop` file.
        found_applications=$(grep -l "^Exec=.*$application" "$apps_dir"/*.desktop)
        if [ -z "$found_applications" ]; then
            echo "[ERROR] Cannot find application $application"
            continue
        fi

        # Let the user choose which .desktop file to use if there are two or
        # more options.
        if [ $(echo "$found_applications" | wc -l) -gt 1 ]; then
            echo "Multiple applications found:"
            echo
            # Print only the filenames.
            echo "$found_applications" | sed "s|$apps_dir/||g"
            echo
            read -p "Which one do you want to use? " selected_application
            app_desktop=""
            # Check if the exact filename is in the list. (optional .desktop suffix)
            for app in $(echo "$found_applications" | sed "s|$apps_dir/||g"); do
                # print debugging lmao
                # echo "[DEBUG] $selected_application = $app"
                if [ "$selected_application" = "$app" ] || [ "$selected_application.desktop" = "$app" ]; then
                    app_desktop="$app"
                    break
                fi
            done
            # If app_desktop is still empty, then the user entered an invalid filename.
            if [ -z "$app_desktop" ]; then
                echo "[ERROR] Invalid application $selected_application."
                echo
                continue
            fi

            # Make sure that the user appended `.desktop` at the end.
            if ! echo "$selected_application" | grep -q ".desktop$"; then
                app_desktop=$(echo "$selected_application.desktop" | sed "s|$apps_dir/||g")
            fi
        else
            app_desktop=$(echo "$found_applications" | sed "s|$apps_dir/||g")
        fi

        # Try to set the default application.
        if ! xdg-mime default "$app_desktop" "$1"; then
            echo "[ERROR] Cannot set default application to $app_desktop"
            echo

        else
            echo "[OK] Default application for $1 is now $app_desktop"
            echo
            break
        fi
    done
}

askDefaultApplication inode/directory "Default file manager" "nautilus, thunar"
askDefaultApplication x-scheme-handler/http "Default web browser" "firefox, chromium"
askDefaultApplication application/pdf "Default PDF reader" "zathura, okular"
askDefaultApplication text/plain "Default text editor" "vim, nvim, emacs, gedit"
askDefaultApplication terminal "Default terminal emulator" "kitty, alacritty"
askDefaultApplication image/png "Default image viewer" "feh, sxiv"
askDefaultApplication video/mp4 "Default video player" "mpv"

echo "Done."
exit 0
