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

---

## Extras

### Grub

If you use Grub as your bootloader, edit `/etc/default/grub`:

```
GRUB_THEME="/usr/share/grub/themes/catppuccin-mocha/theme.txt"
```
