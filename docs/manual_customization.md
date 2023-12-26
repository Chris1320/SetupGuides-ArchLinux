# Customization

Now that you have a new Arch Linux system, we will now start performing
customizations in it.

## Installing An AUR Helper

[Install Paru](https://github.com/Morganamilo/paru). This is the AUR helper
that we will use.

```bash
sudo pacman -S --needed base-devel  # If it is not yet installed

# Clone the repo in a temp directory.
export PARU_TMP_DIR=$(mktemp -d)
git clone https://aur.archlinux.org/paru.git "${PARU_TMP_DIR}/paru"

# build and install paru.
cd "${PARU_TMP_DIR}/paru"
makepkg -si

# Go back home and remove the created temp directory.
cd ~
rm -rf $PARU_TMP_DIR
unset $PARU_TMP_DIR
```

## Downloading the Dotfiles

Install `git` and `git-lfs`, and clone this repository.

```bash
paru -S git git-lfs
git clone https://github.com/SetupGuides/ArchLinux.git ~/ArchLinuxDotfiles
cd ~/ArchLinuxDotfiles
```

From now on, this guide will assume that you are in `~/ArchLinuxDotfiles` directory
unless specified.

## Custom Fonts and Icons

We are going to use the following fonts and icons, so it's best to install it now.

```bash
paru -Syu otf-font-awesome ttf-jetbrains-mono-nerd papirus-icon-theme
```

## Useful Packages

It is recommended to install and enable the following packages.

```bash
paru -S acpid avahi
systemctl enable acpid.service avahi-daemon.service
```

### Enable Printer Support

```bash
paru -S system-config-printer sane \
    foomatic-db foomatic-db-engine \
    gutenprint gsfonts \
    cups cups-pdf cups-filters
systemctl enable cups.service saned.socket
```

### Enable TRIM for SSDs

```bash
systemctl enable fstrim.timer
```

## Next Steps

- [Installing and Setting Up The Desktop](./installing_and_setting_up_the_desktop.md)

---

- Previous: [Automatic Installation](./automatic_customization.md)
- Next: [Installing and Setting Up The Desktop](./installing_and_setting_up_the_desktop.md)
