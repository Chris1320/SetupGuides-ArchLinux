# Arch Linux

> **NOTE**: This page is a work-in-progress.

## Installation

This guide assumes that you've successfully installed Arch Linux by following their [installation guide](https://wiki.archlinux.org/title/Installation_guide) which can be found in their [wiki](https://wiki.archlinux.org/). This guide also assumes that you've made a [non-root user](#Setting-up-a-non-root-user) in your system and is currently active, and you are currently connected to the internet.

| Software                 | Description                                 | Link                                                                                        |
| ------------------------ | ------------------------------------------- | ------------------------------------------------------------------------------------------- |
| Hyprland                 | A dynamic tiling Wayland compositor.        | [Homepage](https://hyprland.org/), [GitHub](https://github.com/hyprwm/Hyprland)             |
| Hyprpaper                | A wayland wallpaper utility.                | [Project Homepage](https://github.com/hyprwm/hyprpaper)                                     |
| Kitty                    | A fast, feature-rich, GPU-based Terminal.   | [Homepage](https://sw.kovidgoyal.net/kitty/), [GitHub](https://github.com/kovidgoyal/kitty) |
| mako                     | A lightweight Wayland notification manager. | [GitHub](https://github.com/emersion/mako)                                                  |
| Pipewire                 | Audio/Video router and processor.           | [Project Homepage](https://gitlab.freedesktop.org/pipewire/pipewire/)                       |
| SDDM                     | A QML-based display manager.                | [GitHub](https://github.com/sddm/sddm)                                                      |
| Waybar                   | A highly customizable Wayland bar.          | [GitHub](https://github.com/Alexays/Waybar)                                                 |

### Pre-Customization

#### Setting up a non-root user

For more information, visit the [Arch wiki](https://wiki.archlinux.org/title/Users_and_groups).

```bash
useradd -m bob  # Create a new user `bob`.

# Add `bob` to the `wheel`, `audio`, `video`, and `storage` groups.
usermod -aG wheel,audio,video,storage bob
```

### 1. Setting up the terminal

1. [Install ZSH](https://github.com/SetupGuides/ZSH). This will be our default shell.
2. [Install Paru](https://github.com/Morganamilo/paru). This is the AUR helper that we will use.
3. Install `sudo`. `$ pacman -Syu sudo`

### 2. Installing packages

1. Install the necessary packages using *pacman* and *paru*.

    ```bash
    sudo pacman -Syu hyprland kitty pipewire qt5-wayland qt6-wayland hyprpaper mako polkit-kde-agent waybar otf-font-awesome
    paru -S sddm-git
    ```

2. Install [*XDG Desktop Portal* for Hyprland](https://wiki.hyprland.org/Useful-Utilities/Hyprland-desktop-portal/).

### 3. Setting up Kitty

1. Set up the terminal's theme using [Catppuccin](https://github.com/catppuccin/catppuccin). See [catppuccin/kitty](https://github.com/catppuccin/kitty) to install the theme.
2. Install JetBrains Mono, nonicons-font, and Nerd Font Symbols.

    ```bash
    pacman -Syu ttf-jetbrains-mono ttf-nerd-fonts-symbols-2048-em-mono
    paru -S nonicons-font
    ```

3. Copy the `./dotfiles/kitty/kitty.conf` file to `~/.config/kitty/kitty.conf`.
4. (Optional) Install *imagemagick* for icat. `$ pacman -Syu imagemagick`
5. (Optional) Alias the following commands. You can change the aliases to whatever you like.

    | Alias   | Command                   |
    | ------- | ------------------------- |
    | `icat`  | `kitty +kitten icat`      |
    | `klip`  | `kitty +kitten clipboard` |

    For ZSH and other bash-like terminals, copy the lines below and paste it to `.zshrc` or similar.

    ```bash
    alias icat="kitty +kitten icat"
    alias klip="kitty +kitten clipboard"
    ```
