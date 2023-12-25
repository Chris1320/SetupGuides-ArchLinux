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

## Next Steps

- [Installing the Desktop](./installing_the_desktop.md)

---

- Previous: [Manual Installation](./manual_installation.md)
- Next: [Installing the Desktop](./installing_the_desktop.md)
