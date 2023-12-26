# Installing and Setting Up The Desktop

In this part of the customization process, we will install
the following programs and their dependencies:

- [blueman](https://github.com/blueman-project/blueman) Bluetooth manager
- [brightnessctl](https://github.com/Hummer12007/brightnessctl) brightness
  control tool
- [dunst](https://dunst-project.org/) notification daemon
  - [libnotify](https://gitlab.gnome.org/GNOME/libnotify) desktop notification library
- [fcitx5](https://github.com/fcitx/fcitx5) input method
- [Firefox](https://www.mozilla.org/en-US/firefox/new/) browser
- [grim](https://git.sr.ht/~emersion/grim) screenshot utility
  - [slurp](https://github.com/emersion/slurp) Wayland region selection tool
  - [swappy](https://github.com/jtheoof/swappy) snapshot editing tool
- [Hyprland](https://hyprland.org/) tiling compositor
  - [catppuccin-cursors-mocha](https://github.com/catppuccin/cursors) cursors
  - [catppuccin-gtk-theme-mocha](https://github.com/catppuccin/gtk) GTK theme
  - [Hyprpaper](https://github.com/hyprwm/hyprpaper) wallpaper utility
  - [GNOME PolicyKit Agent](https://gitlab.gnome.org/Archive/policykit-gnome)
- [KeePassXC](https://keepassxc.org/) password manager
- [Kitty](https://sw.kovidgoyal.net/kitty/) terminal emulator
- [PipeWire](https://pipewire.org) audio/video router and processor
  - [EasyEffects](https://github.com/wwmm/easyeffects) audio effects for PipeWire
  - [playerctl](https://github.com/altdesktop/playerctl) mpris media player controller
  - [WirePlumber](https://pipewire.pages.freedesktop.org/wireplumber/)
    PipeWire session/policy manager
- [rofi](https://github.com/lbonn/rofi) window switcher, run dialog, and dmenu replacement
  - [rofimoji](https://github.com/fdw/rofimoji) character picker for rofi
- [SDDM](https://github.com/sddm/sddm/) display manager
- [swaylock-effects](https://github.com/jirutka/swaylock-effects) screen locker
- [Thunar](https://docs.xfce.org/xfce/thunar/start) file manager
  - [Gnome Virtual File System](https://wiki.gnome.org/Projects/gvfs)
  - [Thunar Archive Plugin](https://goodies.xfce.org/projects/thunar-plugins/thunar-archive-plugin)
    - [file-roller](https://wiki.gnome.org/Apps/FileRoller)
  - [Thunar Media Tags Plugin](https://goodies.xfce.org/projects/thunar-plugins/thunar-media-tags-plugin)
  - [Thunar Volume Manager](https://goodies.xfce.org/projects/thunar-plugins/thunar-volman)
  - [Tumbler](https://gitlab.xfce.org/xfce/tumbler) thumbnail generator
    - [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer) video thumbnailer
    - [Folder thumbnailer](https://github.com/j-james/thunar-folder-thumbnails)
    - [RAW thumbnailer](https://code.google.com/archive/p/raw-thumbnailer/)
- [Waybar](https://github.com/Alexays/Waybar) Wayland bar
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) copy/paste utility
  - [cliphist](https://github.com/sentriz/cliphist) clipboard manager

```bash
paru -S \
    blueman \
    brightnessctl \
    dunst libnotify \
    fcitx5 \
    firefox \
    grim slurp swappy \
    hyprland hyprpaper polkit-gnome \
        catppuccin-cursors-mocha catppuccin-gtk-theme-mocha \
    keepassxc \
    kitty \
    pipewire pipewire-audio pipewire-pulse lib32-pipewire \
        easyeffects playerctl wireplumber \
    rofi-lbonn-wayland-git rofimoji \
    sddm-git \
    swaylock-effects-git \
    thunar gvfs \
        thunar-archive-plugin file-roller \
        thunar-media-tags-plugin thunar-volman \
        tumbler tumbler-extra-thumbnailers raw-thumbnailer \
            ffmpegthumbnailer \
    waybar-hyprland-git \
    wl-clipboard cliphist \
```

You may want to read the installation instructions of each programs
in case your hardware/software configuration needs extra installation
steps.

- [Hyprland Master Tutorial](https://wiki.hyprland.org/Getting-Started/Master-Tutorial/)

---

- Previous: [Manual Customization](./manual_customization.md)
- Next: [Setting Up Hyprland](./setting_up_hyprland.md)
