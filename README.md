<div align="center">
    <h1>Arch Linux Dotfiles</h1>
    <img src="https://img.shields.io/github/directory-file-count/SetupGuides/ArchLinux/dotfiles?color=%23cba6f7&label=Dotfiles&style=for-the-badge">
    <img src="https://img.shields.io/github/directory-file-count/SetupGuides/ArchLinux/scripts?color=%23b4befe&label=Scripts&style=for-the-badge">
    <img src="https://img.shields.io/github/issues-raw/SetupGuides/ArchLinux?color=%23f38ba8&style=for-the-badge">
    <img src="https://img.shields.io/github/last-commit/SetupGuides/ArchLinux?color=%23f9e2af&style=for-the-badge">
</div>

-----

- [Description](#description)
- [Installation](#installation)
    - [Automatic](#automatic-installation)
    - [Manual](#manual-installation)
        - [Pre-customization](#pre-customization)
            - [Setting up a non-root user](#setting-up-a-non-root-user)
        - [Customization](#customization)

-----

## Description

This repository contains most of my dotfiles that are used in my Arch Linux installation. You can use the [auto-install script](#automatic-installation) (WIP) to automatically install Arch Linux and the dotfiles in your system.

However, I don't guarantee that the installer covers all your needs. In such cases (or you probably do not want to start from scratch), this guide assumes that...

- You've successfully installed Arch Linux by following their [installation guide](https://wiki.archlinux.org/title/Installation_guide) which can be found in their [wiki](https://wiki.archlinux.org/).
- You have made a [non-root user](#setting-up-a-non-root-user) in your system and is currently active.
- You are currently connected to the internet.

Some, if not all of the dotfiles, can also be used in other operating systems/distributions, but it's up to you on how you will do it since I haven't tested it on other systems yet.

> **NOTE**: This page is currently under active development. Documentation might be outdated because the dotfiles/scripts are updated frequently.

<div align="center">
    <table>
        <thead><th colspan="3">Environment</th></thead>
        <tbody>
            <tr>
                <td rowspan="8">Desktop</td>
                <td>Compositor</td>
                <td><a href="https://hyprland.org/">Hyprland</a></td>
            </tr>
            <tr>
                <td>Bar</td>
                <td><a href="https://github.com/Alexays/Waybar">Waybar</a></td>
            </tr>
            <tr>
                <td>Widgets</td>
                <td><a href="https://github.com/elkowar/eww">ElKowars wacky widgets</a></td>
            </tr>
            <tr>
                <td>Launcher</td>
                <td><a href="https://github.com/lbonn/rofi">Rofi</a></td>
            </tr>
            <tr>
                <td>Notification Manager</td>
                <td><a href="https://github.com/dunst-project/dunst">Dunst</a></td>
            </tr>
            <tr>
                <td>Wallpaper Utility</td>
                <td><a href="https://github.com/hyprwm/hyprpaper">Hyprpaper</a></td>
            </tr>
            <tr>
                <td>Lockscreen</td>
                <td><a href="https://github.com/jirutka/swaylock-effects">Swaylock</a></td>
            </tr>
            <tr>
                <td>Display Manager</td>
                <td><a href="https://github.com/sddm/sddm">SDDM</a></td>
            </tr>
            <tr>
                <td>Logout Menu</td>
                <td><a href="https://github.com/ArtsyMacaw/wlogout">WLogout</a></td>
            </tr>
            <tr>
                <td rowspan="5">Desktop Applications</td>
                <td>Terminal</td>
                <td><a href="https://sw.kovidgoyal.net/kitty/">Kitty</a></td>
            </tr>
            <tr>
                <td>Browser</td>
                <td><a href="https://firefox.com/">Firefox</a></td>
            </tr>
            <tr>
                <td>File Manager (GUI)</td>
                <td><a href="https://docs.xfce.org/xfce/thunar/start">Thunar</a></td>
            </tr>
            <tr>
                <td>Audio Effects</td>
                <td><a href="https://github.com/wwmm/easyeffects">Easy Effects</a></td>
            </tr>
            <tr>
                <td>Document Viewer</td>
                <td><a href="https://pwmt.org/projects/zathura">Zathura</a></td>
            </tr>
            <tr>
                <td rowspan="5"> Terminal Applications</td>
                <td>Shell</td>
                <td><a href="https://www.zsh.org/">ZSH</a></td>
            </tr>
            <tr>
                <td>AUR Helper</td>
                <td><a href="https://github.com/Morganamilo/paru">Paru</a></td>
            </tr>
            <tr>
                <td>File Manager (TUI)</td>
                <td><a href="https://midnight-commander.org/">mc</a></td>
            </tr>
            <tr>
                <td>Process Viewer</td>
                <td><a href="https://github.com/aristocratos/btop">btop</a></td>
            </tr>
            <tr>
                <td>Audio Visualizer</td>
                <td><a href="https://github.com/karlstav/cava">cava</a></td>
            </tr>
            <tr>
                <td rowspan="5">Back-End/Utilities</td>
                <td>Administration</td>
                <td><a href="https://www.sudo.ws/sudo/">sudo</a></td>
            </tr>
            <tr>
                <td>Authentication Agent</td>
                <td><a href="https://gitlab.gnome.org/Archive/policykit-gnome">GNOME Polkit Authentication Agent</a></td>
            </tr>
            <tr>
                <td>Secrets/Password Manager</td>
                <td><a href="https://keepassxc.org/">KeePassXC</a></td>
            </tr>
            <tr>
                <td>Network Manager</td>
                <td<a href="https://networkmanager.dev/">NetworkManager</a></td>
            </tr>
            <tr>
                <td>Bluetooth Manager</td>
                <td<a href="https://github.com/blueman-project/blueman">Blueman</a></td>
            </tr>
            <tr>
                <td>Audio/Video Processor</td>
                <td><a href="https://pipewire.org">Pipewire</a></td>
            </tr>
            <tr>
                <td>Input Method</td>
                <td><a href="https://github.com/fcitx/fcitx5">Fcitx5</a></td>
            </tr>
        </tbody>
    </table>
</div>

- Fonts used: [JetBrains Mono (Nerd Fonts)](https://github.com/ryanoasis/nerd-fonts) & [Font Awesome](https://fontawesome.com/)
- Colorscheme: [Catppuccin](https://github.com/catppuccin/catppuccin)

## Installation

### Automatic Installation

> **NOTE**: Work-in-progress

### Manual Installation

> **NOTE**: Work-in-progress

To manually set up your system, follow the [pre-customization](#pre-customization) section guide.

#### Pre-customization

This section assumes that you have just finished installing Arch Linux in your system.

##### Setting up a non-root user

A common security practice is that you should **not** use the root account unless needed and you know that it is safe to run. To create a non-root user, run the commands below and change the parameters to the values you desire.

> For more information, visit the [Arch wiki](https://wiki.archlinux.org/title/Users_and_groups).

```bash
useradd -m bob  # Create a new user `bob`. Change this to something you want.

# Add `bob` to the `wheel`, `audio`, `video`, and `storage` groups.
# Change `bob` to the username you've set in the command above.
usermod -aG wheel,audio,video,storage bob
```

Switch to the new user after creating it by running `su <username>` or re-logging in. This will now be your default user account.

#### Customization

##### 1. Setting up the terminal

1. [Install ZSH](https://github.com/SetupGuides/ZSH). This will be our default shell.
2. [Install Paru](https://github.com/Morganamilo/paru). This is the AUR helper that we will use.
3. Install sudo. `$ pacman -Syu sudo`

##### 2. Installing the necessary packages

1. Install the needed packages using *paru*.

    ```bash
    # Note: You can combine them all into one `paru` command but
    # I separated them just to show you how the packages relate to each other.

    # Desktop
    paru -Syu hyprland qt5-wayland qt6-wayland xdg-desktop-portal-hyprland-git \
        waybar-hyprland-git \
        eww-wayland-git jq \
        rofi-lbonn-wayland-git rofimoji \
        dunst \
        hyprpaper \
        swaylock-effects-git \
        sddm-git \
        wlogout

    # Desktop Applications
    paru -Syu kitty imagemagick python-pygments \
        firefox \
        thunar thunar-archive-plugin thunar-volman gvfs tumbler ffmpegthumbnailer file-roller \
        easyeffects calf lsp-plugins-lv2 zam-plugins-lv2 mda.lv2 \
        zathura zathura-cb zathura-djvu zathura-pdf-mupdf

    # Terminal Applications
    paru -Syu mc \
        btop \
        cava-git \
        pfetch

    # Utilities
    paru -Syu polkit-gnome \
        keepassxc \
        networkmanager \
        blueman \
        pipewire \
        fcitx5 \
        grim gnome-tweaks

    # Fonts
    paru -Syu otf-font-awesome ttf-jetbrains-mono-nerd

    # Icon themes
    paru -Syu papirus-icon-theme

    # Catpuccin theme for certain applications
    paru -Syu catppuccin-gtk-theme-mocha catppuccin-cursors-mocha \
        catppuccin-mocha-grub-theme-git papirus-folders-catppuccin-git \
        sddm-catppuccin-git

    # Sound theme
    paru -Syu sound-theme-freedesktop
    ```
