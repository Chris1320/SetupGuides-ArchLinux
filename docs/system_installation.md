# System Installation

If you haven't installed Arch Linux yet, continue reading. Otherwise, you
might want to skip to the [configuration](./configuration.md) step.

I recommend that you read the [Arch Linux Wiki](https://wiki.archlinux.org/)'s
[installation guide](https://wiki.archlinux.org/title/Installation_guide)
instead since it is more updated and accurate than a guide that is maintained
by one hobbyist like me. I also recommend reading
[arch.d3sox.me](https://arch.d3sox.me/) if you have trouble understanding the
wiki.

## Pre-Installation

### Preparing the Installation Medium

I assume that you know how to boot into the Arch Linux ISO. You can download
the ISO from [their website](https://www.archlinux.org/download/), and use
[Ventoy](https://www.ventoy.net/en/index.html) to boot into your USB Flash
Drive.

**After this point, I assume that you are now in the live ArchISO system.**

### Preparing the Console

If you are not using a US keyboard, you might want to change your keyboard
layout.

```bash
localectl list-keymaps  # list available layouts
loadkeys <keymap> # load a keymap. e.g., `de-latin1`
```

### Verifying Internet Connection

Internet connection via Ethernet should be working out of the box. If you
are using a wireless connection, perform the following commands:

```bash
iwctl
device list
# your device name might be different (replace wlan0)
station wlan0 scan
station wlan0 get-networks
# replace <SSID> with your network name from the previous command
station wlan0 connect <SSID>
exit
```

> If you are having problems turning on your wireless NIC, make sure that it
> is not being soft-blocked by `rfkill`.

To make sure that you have an internet connection, ping the Arch Linux website.

```bash
ping -c 4 archlinux.org
```

### Setting Up Time and Date

Make sure that the time and date is synchronized.

```bash
timedatectl set-ntp true
```

### Check if The System Booted in UEFI

```bash
ls /sys/firmware/efi/efivars
```

If the directory does not exist, you are in BIOS mode. It is most likely that
you want to use UEFI, so check the wiki to know how to boot into UEFI mode.

## Storage Preparation

### Partitioning and Mounting the Disks

List all block devices by running the following command:

```bash
fdisk -l
```

In my case, my main storage device is located at `/dev/sda`. So we run the
following command: (Your device might have a different name)

```bash
fdisk /dev/sda
```

Partition the device following the structure shown in
[Environment > Disk Partitions](./environment.md#disk-partitions). If you
have different needs, you can see more examples in the
[Arch Linux Wiki](https://wiki.archlinux.org/title/Partitioning#Example_layouts)
and [d3sox](https://arch.d3sox.me/installation/partitioning-formatting#size-recommendations)'s
guide. After saving the changes made by `fdisk`, create the filesystems.

```bash
mkfs.fat -F32 -n EFI /dev/sda1  # Create a FAT32 filesystem in `/dev/sda1` with label "EFI"
mkswap -L SWAP /dev/sda2  # Create a SWAP filesystem in `/dev/sda2` with label "SWAP"
mkfs.btrfs -L ROOT /dev/sda3  # Create a BTRFS filesystem in `/dev/sda3` with label "ROOT"
mkfs.ext4 -L HOME /dev.sda4  # Create an EXT4  filesystem in `/dev/sda4` with label "HOME"

# Mount the partitions in their respective mountpoints.
mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
mount --mkdir /dev/sda4 /mnt/home
swapon /dev/sda2
```

## Installing Arch Linux

### Rank the Mirrors

Use [reflector](https://wiki.archlinux.org/title/Reflector) to rank the mirror servers.

```bash
reflector \
    --age 15 \
    --protocol https \
    --sort rate \
    --save /etc/pacman.d/mirrorlist
```

### Perform the Base Installation

Use the `pacstrap` command to install Arch Linux into your system.

> **WARNING**: To ensure system stability, append the microcode package for
> your CPU to the following command:
>
> - `amd-ucode` for AMD CPUs
> - `intel-ucode` for Intel CPUs
>
> See [Arch Linux Wiki > Microcode](https://wiki.archlinux.org/index.php/Microcode)

```bash
pacstrap -K /mnt \
    base base-devel linux linux-firmware \
    networkmanager wpa_supplicant \
    sysfsutils usbutils btrfs-progs e2fsprogs \
    inetutils dhcping traceroute \
    nano less which tree sudo \
    man-db man-pages
```

Append more package names as you wish. This command may take a while to complete.

### Generate `fstab`

Generate an fstab file by running either of the following commands:

```bash
genfstab -L /mnt >> /mnt/etc/fstab  # Define by labels
genfstab -U /mnt >> /mnt/etc/fstab  # Define by UUIDs
```

> **NOTE**: Check the `/mnt/etc/fstab` file for any errors.

### Chroot into Your New Arch Linux System

```bash
arch-chroot /mnt
```

### Install Bootloader

In this step, I assume that you are installing on a UEFI system. Otherwise,
check [d3sox](https://arch.d3sox.me/installation/install-bootloader) for
more information.

```bash
pacman -S grub efibootmgr os-prober
mkdir -p /boot/EFI/GRUB
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

> **TIP**: If you want to automatically detect other operating systems,
> run `nano /etc/default/grub` and add/uncomment the following line:
>
> ```bash
> GRUB_DISABLE_OS_PROBER=false
> ```
>
> **NOTE**: If you forgot to perform `grub-mkconfig` and shut down/reboot the
> system instead (which I _totally_ did not do while installing Arch), just
> boot into your live USB again, mount the partitions, and `chroot` into
> your system.

### Setup Hostname

`<YOUR_HOSTNAME>` will be the name of your machine. Change it to whatever you
like, but following [RFC1178](https://tools.ietf.org/html/rfc1178) is recommended.

```bash
echo <YOUR_HOSTNAME> /etc/hostname
nano /etc/hosts
```

When the text editor opens, add the following to the file and save:

```text
127.0.0.1   localhost
::1         localhost
127.0.1.1   <YOUR_HOSTNAME>.local  <YOUR_HOSTNAME>
```

### Setting Up Locale

Uncomment the languages that you plan to use in `/etc/locale.gen` and then
generate the locales.

```bash
nano /etc/locale.gen
locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf  # You can change the locale if you want
export LANG=en_US.UTF-8
```

### Update the Time

```bash
# Replace `Region/City` with your region and city.
# tab-completion is available.
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc
```

### Configure Pacman

```bash
nano /etc/pacman.conf
```

#### Enable `multilib` Repository

Uncomment the following lines to make 32-bit libraries available to download.

```text
[multilib]
Include = /etc/pacman.d/mirrorlist
```

#### Enable Parallel Downloads

Uncomment the following line to enable parallel downloading of files. You can
change the value to whatever you like.

```text
ParallelDownloads = 5
```

#### Other Stuff

Uncomment/Add the following lines under `Misc options`:

1. `Color`
2. `ILoveCandy`
3. `VerbosePkgLists`

#### Post-Configuration

After editing the configuration file, you may now save and close it. Run
`pacman -Syu` to update the repositories.

### Setting Up Users

> **TIP**: It is recommended to use strong passwords for your user accounts.

#### Set Root Password

```bash
passwd
```

#### Add A Non-Root User Account

A common security practice is that you should **not** use the root account
unless needed and you know that it is safe to run. To create a non-root
user, run the commands below and change the parameters to the values you desire.

> For more information, visit the
> [Arch wiki](https://wiki.archlinux.org/title/Users_and_groups).

```bash
# Change <USERNAME> with your desired username.
useradd -mG audio,video,input,storage,wheel,sys,log,rfkill,lp,adm -s /bin/bash <USERNAME>
passwd <USERNAME>
```

To enable `sudo` in the newly-created account, run the following command:

```bash
EDITOR=nano visudo
```

And uncomment the following line to allow members of the group `wheel` to execute
any command:

```text
%wheel ALL=(ALL) ALL
```

## Enable `NetworkManager` Service

```bash
systemctl enable NetworkManager.service
systemctl start NetworkManager.service
```

## Reboot

```bash
exit  # Exit the chroot environment
reboot  # Reboot the system
```

---

- Previous: [Automatic Installation](./automatic_installation.md)
