# Arch Linux

> **NOTE**: This page is a work-in-progress.

## Installation

This guide assumes that you've successfully installed Arch Linux by following their [installation guide](https://wiki.archlinux.org/title/Installation_guide) which can be found in their [wiki](https://wiki.archlinux.org/). This guide also assumes that you've made a [non-root user](#Setting-up-a-non-root-user) in your system and is currently active, and you are currently connected to the internet.

### Pre-Customization

#### Setting up a non-root user

For more information, visit the [Arch wiki](https://wiki.archlinux.org/title/Users_and_groups).

```sh
useradd -m bob  # Create a new user `bob`.

# Add `bob` to the `wheel`, `audio`, `video`, and `storage` groups.
usermod -aG wheel,audio,video,storage bob
```

### 1. Setting up the terminal

1. [Install ZSH](https://github.com/SetupGuides/ZSH). This will be our default shell.
2. [Install Paru](https://github.com/Morganamilo/paru). This is the AUR helper that we will use.

### 2. Installing packages

1. Install *hyprland*. `$ sudo pacman -S hyprland`
2. Install *kitty* terminal. `$ sudo pacman -S kitty`
3. Install *pipewire*. `$ sudo pacman -S pipewire`
4. Install *qt5-wayland* and *qt6-wayland* for QT Wayland support. `pacman -S qt5-wayland qt6-wayland`
5. Install *SDDM* login manager. `$ paru -S sddm-git`
6. Install *KDE authentication agent*. `$ pacman -S polkit-kde-agent`
7. Install *Eww*. `$ paru -S eww-wayland`
8. Install [*XDG Desktop Portal* for Hyprland](https://wiki.hyprland.org/Useful-Utilities/Hyprland-desktop-portal/).
9. Install *mako* notification manager. `$ pacman -S mako`

### 3. Setting up Kitty

First, we will set up the terminal's theme using [Catppuccin](https://github.com/catppuccin/catppuccin). See [catppuccin/kitty](https://github.com/catppuccin/kitty) to install the theme.
