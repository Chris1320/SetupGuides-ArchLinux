# Environment

## Hardware

I am using Arch Linux on my laptop because it gives me a functional system
while having low resource usage. I am using an old Lenovo G50-70 laptop with
an Intel Core i3-4030U, 4GB RAM, and 500GB HDD storage.

## Software

### Disk Partitions

During the installation I've configured my machine to have the following
disk partitions:

| Device      | Size                    | Mountpoint | Filesystem | Label | Description       |
| ----------- | ----------------------- | ---------- | ---------- | ----- | ----------------- |
| `/dev/sda1` | 300M                    | /mnt/boot  | FAT32      | EFI   | EFI Partition     |
| `/dev/sda2` | 8G                      | SWAP       | SWAP       | SWAP  | Swap Partition    |
| `/dev/sda3` | 60G                     | /mnt       | BTRFS      | ROOT  | `/` Partition     |
| `/dev/sda4` | Remaining of the Device | /mnt/home  | EXT4       | HOME  | `/home` Partition |

### Programs Used

This Arch Linux configuration is using the following programs:

<div align="center">
  <table>
    <tbody>
      <tr>
        <td rowspan="9">Desktop</td>
        <td>Compositor</td>
        <td><a href="https://hyprland.org/">Hyprland</a></td>
      </tr>
      <tr>
        <td>Bar</td>
        <td><a href="https://github.com/Alexays/Waybar">Waybar</a></td>
      </tr>
      <tr>
        <td>Widgets</td>
        <td>
          <a href="https://github.com/elkowar/eww">ElKowars wacky widgets</a>
        </td>
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
        <td>
          <a href="https://github.com/jirutka/swaylock-effects">Swaylock</a>
        </td>
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
        <td>
          <a href="https://docs.xfce.org/xfce/thunar/start">Thunar</a>
        </td>
      </tr>
      <tr>
        <td>Audio Effects</td>
        <td>
          <a href="https://github.com/wwmm/easyeffects">Easy Effects</a>
        </td>
      </tr>
      <tr>
        <td>Document Viewer</td>
        <td><a href="https://pwmt.org/projects/zathura">Zathura</a></td>
      </tr>
      <tr>
        <td rowspan="5">Terminal Applications</td>
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
        <td rowspan="7">Back-End/Utilities</td>
        <td>Administration</td>
        <td><a href="https://www.sudo.ws/sudo/">sudo</a></td>
      </tr>
      <tr>
        <td>Authentication Agent</td>
        <td>
          <a href="https://gitlab.gnome.org/Archive/policykit-gnome"
            >GNOME Polkit Authentication Agent</a
          >
        </td>
      </tr>
      <tr>
        <td>Secrets/Password Manager</td>
        <td><a href="https://keepassxc.org/">KeePassXC</a></td>
      </tr>
      <tr>
        <td>Network Manager</td>
        <td><a href="https://networkmanager.dev/">NetworkManager</a></td>
      </tr>
      <tr>
        <td>Bluetooth Manager</td>
        <td>
          <a href="https://github.com/blueman-project/blueman">Blueman</a>
        </td>
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
- Colorscheme: [Catppuccin Mocha](https://github.com/catppuccin/catppuccin)

---

- Previous: [Introduction](../README.md)
- Next: [Automatic Installation](./automatic_installation.md)
