# Arch Linux

> **NOTE**: This page is a work-in-progress.

## Installation

This guide assumes that you've successfully installed Arch Linux by following their [installation guide](https://wiki.archlinux.org/title/Installation_guide) which can be found in their [wiki](https://wiki.archlinux.org/). This guide also assumes that you've made a [non-root user](#Setting-up-a-non-root-user) in your system and is currently active, and you are currently connected to the internet.

- **Desktop**
    - Bar: [Waybar](https://github.com/Alexays/Waybar)
    - Compositor: [Hyprland](https://hyprland.org/)
    - Display Manager: [SDDM](https://github.com/sddm/sddm)
    - Launcher: [Wofi](https://hg.sr.ht/~scoopta/wofi)
    - Logout Menu: [WLogout](https://github.com/ArtsyMacaw/wlogout)
    - Notifications: [Dunst](https://github.com/dunst-project/dunst)
    - Wallpaper Utility: [Hyprpaper](https://github.com/hyprwm/hyprpaper)
- **Productivity**
    - Browser: [Firefox](https://firefox.com/)
    - GUI File Manager: [Thunar](https://docs.xfce.org/xfce/thunar/start)
    - Input Method: [Fcitx5](https://github.com/fcitx/fcitx5)
    - Screenshot Utility: [Flameshot](https://github.com/flameshot-org/flameshot)
    - Terminal: [Kitty](https://sw.kovidgoyal.net/kitty/)
- **System Utilities**:
    - Audio: [Pipewire](https://gitlab.freedesktop.org/pipewire/pipewire/)

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
    sudo pacman -Syu hyprland kitty firefox pipewire pipewire-pulse qt5-wayland qt6-wayland hyprpaper polkit-kde-agent waybar otf-font-awesome thunar gvfs tumbler catppuccin-gtk-theme-mocha gnome-tweaks ffmpegthumbnailer flameshot grim wofi cava
    paru -S sddm-git
    ```

2. Install [*XDG Desktop Portal* for Hyprland](https://wiki.hyprland.org/Useful-Utilities/Hyprland-desktop-portal/).

### 3. Setting up Kitty

1. Install JetBrains Mono, nonicons-font, and Nerd Font Symbols.

    ```bash
    pacman -Syu ttf-jetbrains-mono ttf-nerd-fonts-symbols-2048-em-mono
    paru -S nonicons-font
    ```

2. Copy the files from `./dotfiles/kitty/` to `~/.config/kitty/`.
3. (Optional) Install *imagemagick* for icat. `$ pacman -Syu imagemagick`
4. (Optional) Alias the following commands. You can change the aliases to whatever you like.

    | Alias   | Command                   |
    | ------- | ------------------------- |
    | `icat`  | `kitty +kitten icat`      |
    | `klip`  | `kitty +kitten clipboard` |

    For ZSH and other bash-like terminals, copy the lines below and paste it to `.zshrc` or similar.

    ```bash
    alias icat="kitty +kitten icat"
    alias klip="kitty +kitten clipboard"
    ```

### 4. Setting up SDDM

1. Enable the SDDM service to start the display manager on boot.

    ```bash
    systemctl enable sddm.service
    ```

2. Install Catppuccin SDDM theme. `$ paru -S sddm-catppuccin-git`
3. Copy `dotfiles/sddm/sddm.conf` `/etc/sddm.conf.d/sddm.conf`.

For more information, visit their [GitHub page](https://github.com/khaneliman/sddm-catppuccin).

### 5. Setting up Hyprland

Copy the files from `dotfiles/hyprland/` to `~/.config/hypr/`.

To customize the background, create a `~/.config/hypr/hyprpaper.conf` file and follow the instructions on their [GitHub homepage](https://github.com/hyprwm/hyprpaper).

### 6. Setting up Dunst

1. Install Papirus icon theme. `$ sudo pacman -S papirus-icon-theme`
2. Copy `dotfiles/dunst/dunstrc` to `~/.config/dunst/dunstrc`.

### 7. Setting up waybar

> work-in-progress

#

-----

## Extras

### Grub

If you use Grub as your bootloader, install `catppuccin-mocha-grub-theme-git` from the AUR and set it as your Grub theme.

```bash
paru -S catppuccin-mocha-grub-theme-git
```

`/etc/default/grub`:

```
GRUB_THEME="/usr/share/grub/themes/catppuccin-mocha"
```
