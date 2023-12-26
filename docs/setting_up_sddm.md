# Setting Up SDDM

<!--
TODO: Update SDDM configuration. Basically, our customizations
in SDDM (except for the `sddm.conf` file) aren't documented.
-->

1. Enable the SDDM service to start the display manager on boot.

   ```bash
   systemctl enable sddm.service
   ```

2. Copy `dotfiles/sddm/sddm.conf` `/etc/sddm.conf.d/sddm.conf`.
3. Edit `/usr/share/sddm/themes/catppuccin/theme.conf` to your preferences.

For more information, visit their [GitHub page](https://github.com/khaneliman/sddm-catppuccin).

---

- Previous: [Setting Up Kitty](./setting_up_kitty.md)
