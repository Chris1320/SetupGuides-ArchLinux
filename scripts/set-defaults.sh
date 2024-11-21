#!/usr/bin/env bash

# Ask the user for default applications for some MIME types.

# Ask the user for the default application.
# $1: An array containing the MIME types to set.
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
        for mimetype in $1; do
            if ! xdg-mime default "$app_desktop" "$mimetype"; then
                echo "[ERROR] Cannot set default application to $app_desktop"
                echo
                mimetype_handler_set_success=false
                break

            else
                echo "[OK] Default application for $mimetype is now $app_desktop"
                mimetype_handler_set_success=true
            fi
        done

        echo
        if $mimetype_handler_set_success; then
            break
        fi
    done
}

filemanager_mimetypes=(
    "inode/directory" # Directory
)
archivemanager_mimetypes=(
    "application/x-freearc"       # Archive document (multiple files embedded)
    "application/x-bzip"          # Bzip archive
    "application/x-bzip2"         # Bzip2 archive
    "application/gzip"            # GZip Compressed Archive
    "application/vnc.rar"         # RAR archive
    "application/x-rar"           # RAR archive
    "application/x-tar"           # Tape Archive (TAR)
    "application/zip"             # ZIP archive
    "application/x-7z-compressed" # 7-zip archive
)
browser_mimetypes=(
    "text/html"              # HyperText Markup Language (HTML)
    "text/xhtml+xml"         # XHTML
    "x-scheme-handler/http"  # HTTP
    "x-scheme-handler/https" # HTTPS
)
ebook_mimetypes=(
    "application/vnd.amazon.ebook" # Amazon Kindle eBook format
    "application/epub+zip"         # Electronic Publication (EPUB)
    "application/pdf"              # Adobe Portable Document Format (PDF)
)
docs_mimetypes=(
    "application/msword"                                                        # Microsoft Word
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document"   # Microsoft Word (OpenXML)
    "application/vnd.oasis.opendocument.presentation"                           # OpenDocument presentation document
    "application/vnd.oasis.opendocument.spreadsheet"                            # OpenDocument spreadsheet document
    "application/vnd.oasis.opendocument.text"                                   # OpenDocument text document
    "application/vin.ms-powerpoint"                                             # Microsoft PowerPoint
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" # Microsoft PowerPoint (OpenXML)
    "application/rtf"                                                           # Rich Text Format (RTF)
    "application/vnd.ms-excel"                                                  # Microsoft Excel
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"         # Microsoft Excel (OpenXML)
)
texteditor_mimetypes=(
    "text/css"                # Cascading Style Sheets (CSS)
    "text/csv"                # Comma-separated values (CSV)
    "text/javascript"         # JavaScript
    "text/json"               # JSON format
    "application/x-httpd-php" # Hypertext Preprocessor (Personal Home Page)
    "text/plain"              # Plain text
    "application/xml"         # XML
    "text/xml"                # XML
)
terminal_mimetypes=(
    "application/x-sh"   # Bourne shell script
    "text/x-shellscript" # Bourne shell script
    "terminal"           # Set as default terminal
)
image_mimetypes=(
    "image/avif"               # AVIF image
    "image/bmp"                # Windows OS/2 Bitmap Graphics
    "image/vnd.microsoft.icon" # Icon format
    "image/jpeg"               # JPEG images
    "image/png"                # Portable Network Graphics
    "image/svg+xml"            # Scalable Vector Graphics (SVG)
    "image/tiff"               # Tagged Image File Format (TIFF)
    "image/webp"               # WEBP image
)
video_mimetypes=(
    "video/x-msvideo"  # AVI: Audio Video Interleave
    "image/gif"        # Graphics Interchange Format (GIF)
    "video/mp4"        # MP4 video
    "video/mpeg"       # MPEG Video
    "video/ogg"        # OGG video
    "video/mp2t"       # MPEG transport stream
    "video/webm"       # WEBM video
    "video/3gpp"       # 3GPP video container
    "video/3gpp2"      # 3GPP2 video container
    "video/x-matroska" # Matroska (MKV) video
)
audio_mimetypes=(
    "audio/midi"   # Musical Instrument Digital Interface (MIDI)
    "audio/x-midi" # Musical Instrument Digital Interface (MIDI)
    "audio/mpeg"   # MP3 audio
    "audio/ogg"    # OGG audio
    "audio/opus"   # Opus audio
    "audio/wav"    # Waveform Audio Format
    "audio/webm"   # WEBM audio
    "audio/3gpp"   # 3GPP audio container
    "audio/3gpp2"  # 3GPP2 audio container
)

# unknown filetype: application/octet-stream

askDefaultApplication "${filemanager_mimetypes[*]}" "Default file manager" "nautilus, thunar"
askDefaultApplication "${archivemanager_mimetypes[*]}" "Default archive manager" "file-roller, xarchiver"
askDefaultApplication "${browser_mimetypes[*]}" "Default web browser" "firefox, chromium"
askDefaultApplication "${ebook_mimetypes[*]}" "Default E-book reader" "zathura, okular"
askDefaultApplication "${docs_mimetypes[*]}" "Default document viewer" "onlyoffice, libreoffice"
askDefaultApplication "${texteditor_mimetypes[*]}" "Default text editor" "vim, nvim, emacs, gedit"
askDefaultApplication "${terminal_mimetypes[*]}" "Default terminal emulator" "kitty, alacritty"
askDefaultApplication "${image_mimetypes[*]}" "Default image viewer" "imv, feh, sxiv"
askDefaultApplication "${video_mimetypes[*]}" "Default video player" "mpv"
askDefaultApplication "${audio_mimetypes[*]}" "Default audio player" "mpv"

echo "Done."
exit 0
