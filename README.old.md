### 2. Installing packages

1. Install the packages using *pacman* and *paru*.

    ```bash
    # Note: You can combine them all into one `paru` command but
    # I separated them to show you how the packages relate to each other.

    # Desktop packages
    sudo pacman -Syu hyprland qt5-wayland qt6-wayland \
        hyprpaper dunst polkit-gnome blueman
    paru -S sddm-git wlogout rofi-lbonn-wayland-git waybar-hyprland-git

    # Other applications that I recommend. You can use alternatives if
    # you like, but you might have to change some things if you
    # continue to follow this guide.
    sudo pacman -Syu firefox kitty btop \
        thunar thunar-volman gvfs tumbler ffmpegthumbnailer \
        flameshot grim imagemagick rofimoji
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
