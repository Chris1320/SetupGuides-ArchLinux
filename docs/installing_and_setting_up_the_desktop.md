# Installing and Setting Up The Desktop

In this part of the customization process, we will install
the following programs and their dependencies:

- [Hyprland](https://hyprland.org/) tiling compositor
- [Kitty](https://sw.kovidgoyal.net/kitty/) terminal emulator
- [SDDM](https://github.com/sddm/sddm/) display manager
- [Waybar](https://github.com/Alexays/Waybar) Wayland bar

```bash
paru -S hyprland kitty sddm-git waybar-hyprland-git
```

You may want to read the installation instructions of each programs
in case your hardware/software configuration needs extra installation
steps.

- [Hyprland Master Tutorial](https://wiki.hyprland.org/Getting-Started/Master-Tutorial/)

Copy the configuration files from this repository to their
respective locations.

```bash
cp -r ./dotfiles/hypr ~/.config/hypr
cp -r ./dotfiles/kitty ~/.config/kitty
cp -r ./dotfiles/waybar ~/.config/waybar

sudo cp -r ./dotfiles/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf
```

> **NOTE**: If you are having problems with Hyprland, see their
> [wiki](https://wiki.hyprland.org/Crashes-and-Bugs/).

---

- Previous: [Manual Customization](./manual_customization.md)
