# Setting Up SDDM

1. Enable the SDDM service to start the display manager on boot.
2. Copy the SDDM configuration file and catppuccin theme configuration to their
   designated locations.

```bash
systemctl enable sddm.service
sudo cp -r ./dotfiles/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf
sudo cp -r ./dotfiles/sddm/sddm-catppuccin-theme/src/catppuccin-mocha /usr/share/sddm/themes/catppuccin-mocha
sudo cp -r ./dotfiles/sddm/custom-theme.conf /usr/share/sddm/themes/catppuccin-mocha/theme.conf
```

> **NOTE**: Make sure that git submodules are pulled before attempting to copy
> the files from `./dotfiles/sddm/sddm-catppuccin-theme` directory.
>
> ```bash
> git submodule update --init --recursive --remote
> ```

For more information, visit their [GitHub page](https://github.com/khaneliman/sddm-catppuccin).

---

- Previous: [Setting Up Kitty](./setting_up_kitty.md)
- Next: [Setting Up dunst](./setting_up_dunst.md)
