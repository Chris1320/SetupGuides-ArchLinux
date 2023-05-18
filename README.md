<div align="center">
    <h1>Arch Linux Dotfiles</h1>
    <img src="https://img.shields.io/github/directory-file-count/SetupGuides/ArchLinux/dotfiles?color=%23cba6f7&label=Dotfiles&style=for-the-badge">
    <img src="https://img.shields.io/github/issues-raw/SetupGuides/ArchLinux?color=%23f38ba8&style=for-the-badge">
    <img src="https://img.shields.io/github/last-commit/SetupGuides/ArchLinux?color=%23f9e2af&style=for-the-badge">
</div>

> **NOTE**: This page is a work-in-progress.

## Installation

This guide assumes that you've successfully installed Arch Linux by following their [installation guide](https://wiki.archlinux.org/title/Installation_guide) which can be found in their [wiki](https://wiki.archlinux.org/). This guide also assumes that you've made a [non-root user](#Setting-up-a-non-root-user) in your system and is currently active, and you are currently connected to the internet.

<div align="center">
    <table>
        <thead>
            <th colspan="2">Environment</th>
        </thead>
        <tbody>
            <tr>
                <td>Audio Visualizer</td>
                <td><a href="https://github.com/karlstav/cava">cava</a></td>
            </tr>
            <tr>
                <td>Authentication Agent</td>
                <td><a href="https://kde.org/plasma-desktop/">Polkit KDE Agent</a></td>
            </tr>
            <tr>
                <td>Bar</td>
                <td><a href="https://github.com/Alexays/Waybar">Waybar</a></td>
            </tr>
            <tr>
                <td>Compositor</td>
                <td><a href="https://hyprland.org/">Hyprland</a></td>
            </tr>
            <tr>
                <td>Display Manager</td>
                <td><a href="https://github.com/sddm/sddm">SDDM</a></td>
            </tr>
            <tr>
                <td>Font</td>
                <td><a href="https://github.com/ryanoasis/nerd-fonts">JetBrains Mono (Nerd Fonts)</a></td>
            </tr>
            <tr>
                <td>Launcher</td>
                <td><a href="https://hg.sr.ht/~scoopta/wofi">Wofi</a></td>
            </tr>
            <tr>
                <td>Lockscreen</td>
                <td><a href="https://github.com/jirutka/swaylock-effects">Swaylock</a></td>
            </tr>
            <tr>
                <td>Logout Menu</td>
                <td><a href="https://github.com/ArtsyMacaw/wlogout">WLogout</a></td>
            </tr>
            <tr>
                <td>Notification Manager</td>
                <td><a href="https://github.com/dunst-project/dunst">Dunst</a></td>
            </tr>
            <tr>
                <td>Shell</td>
                <td><a href="https://www.zsh.org/">ZSH</a></td>
            </tr>
            <tr>
                <td>Terminal</td>
                <td><a href="https://sw.kovidgoyal.net/kitty/">Kitty</a></td>
            </tr>
            <tr>
                <td>Wallpaper Utility</td>
                <td><a href="https://github.com/hyprwm/hyprpaper">Hyprpaper</a></td>
            </tr>
        </tbody>
    </table>
</div>

<!-- old list -->
- **Productivity**
    - Browser: [Firefox](https://firefox.com/)
    - GUI File Manager: [Thunar](https://docs.xfce.org/xfce/thunar/start)
    - Input Method: [Fcitx5](https://github.com/fcitx/fcitx5)
    - Screenshot Utility: [Flameshot](https://github.com/flameshot-org/flameshot)
- **System Utilities**:
    - Administration: [sudo](https://www.sudo.ws/sudo/)
    - AUR Helper: [Paru](https://github.com/Morganamilo/paru)
    - Process Viewer: [htop](https://htop.dev/)

### Pre-Customization

#### Setting up a non-root user

For more information, visit the [Arch wiki](https://wiki.archlinux.org/title/Users_and_groups).

```bash
useradd -m bob  # Create a new user `bob`.

# Add `bob` to the `wheel`, `audio`, `video`, and `storage` groups.
usermod -aG wheel,audio,video,storage bob
```

Switch to the new user after creating it. This will now be your default user account.

### 1. Setting up the terminal

1. [Install ZSH](https://github.com/SetupGuides/ZSH). This will be our default shell.
2. [Install Paru](https://github.com/Morganamilo/paru). This is the AUR helper that we will use.
3. Install sudo. `$ pacman -Syu sudo`

### 2. Installing packages

1. Install the packages using *pacman* and *paru*.

    ```bash
    # Note: You can combine them all into one `paru` command but
    # I separated them to show you how the packages relate to each other.

    # Desktop packages
    sudo pacman -Syu hyprland qt5-wayland qt6-wayland \
        hyprpaper waybar dunst wofi polkit-kde-agent
    paru -S sddm-git wlogout

    # Other applications that I recommend. You can use alternatives if
    # you like, but you might have to change some things if you
    # continue to follow this guide.
    sudo pacman -Syu firefox kitty htop \
        thunar thunar-volman gvfs tumbler ffmpegthumbnailer \
        flameshot grim imagemagick
    paru -S cava-git pfetch

    # Install themes and fonts
    sudo pacman -Syu otf-font-awesome ttf-jetbrains-mono-nerd \
        gnome-tweaks papirus-icon-theme
    paru -S catppuccin-gtk-theme-mocha catppuccin-cursors-mocha \
        catppuccin-mocha-grub-theme-git papirus-folders-catppuccin-git \
        sddm-catppuccin-git sound-theme-freedesktop
    ```

2. Install [*XDG Desktop Portal* for Hyprland](https://wiki.hyprland.org/Useful-Utilities/Hyprland-desktop-portal/).

### 3. Setting up Kitty

1. Copy the files from `./dotfiles/kitty/` to `~/.config/kitty/`.
2. (Optional) Alias the following commands. You can change the aliases to whatever you like.

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

2. Copy `dotfiles/sddm/sddm.conf` `/etc/sddm.conf.d/sddm.conf`.
3. Edit `/usr/share/sddm/themes/catppuccin/theme.conf` to your preferences.

For more information, visit their [GitHub page](https://github.com/khaneliman/sddm-catppuccin).

### 5. Setting up Hyprland

Copy the files from `dotfiles/hyprland/` to `~/.config/hypr/`.

To customize the background, create a `~/.config/hypr/hyprpaper.conf` file and follow the instructions on their [GitHub homepage](https://github.com/hyprwm/hyprpaper).

### 6. Setting up Dunst

Copy `dotfiles/dunst/dunstrc` to `~/.config/dunst/dunstrc`.

### 7. Setting up waybar

Copy `./dotfiles/waybar/` to `~/.config/waybar/`.

#

-----

## Extras

### Grub

If you use Grub as your bootloader, edit `/etc/default/grub`:

```
GRUB_THEME="/usr/share/grub/themes/catppuccin-mocha/theme.txt"
```
