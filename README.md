<div align="center">
    <h1>Arch Linux Dotfiles</h1>
    <img src="https://img.shields.io/github/directory-file-count/SetupGuides/ArchLinux/dotfiles?color=%23cba6f7&label=Dotfiles&style=for-the-badge">
    <img src="https://img.shields.io/github/directory-file-count/SetupGuides/ArchLinux/scripts?color=%23b4befe&label=Scripts&style=for-the-badge">
    <img src="https://img.shields.io/github/issues-raw/SetupGuides/ArchLinux?color=%23f38ba8&style=for-the-badge">
    <img src="https://img.shields.io/github/last-commit/SetupGuides/ArchLinux?color=%23f9e2af&style=for-the-badge">
</div>

This repository contains most of my dotfiles that are used in my Arch Linux installation. You can use the *auto-install script* (WIP) to automatically install Arch Linux and the dotfiles in your system.

However, I don't guarantee that the installer covers all your needs. In such cases (or you probably do not want to start from scratch), this guide assumes that...

- You've successfully installed Arch Linux by following their [installation guide](https://wiki.archlinux.org/title/Installation_guide) which can be found in their [wiki](https://wiki.archlinux.org/).
- You have made a [non-root user](#Setting-up-a-non-root-user) in your system and is currently active.
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
                <td>File Manager</td>
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
                <td>File Manager</td>
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

Fonts used: [JetBrains Mono (Nerd Fonts)](https://github.com/ryanoasis/nerd-fonts)
