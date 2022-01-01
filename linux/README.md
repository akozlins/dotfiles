# linux

## pacman

```
# mark all packages as non-explicitly installed
sudo pacman -D --asdeps $(pacman -Qqe)
# mark base packages as explicitly installed
sudo pacman -D --asexplicit base
# list unrequired and optional dependencies
pacman -Qdtt
# mark package as explicitly installed
sudo pacman -D --asexplicit <package>
# ...
pacman -Qe | awk '{print $1}' | xargs -n 1 pactree -r -d 1
```

## fonts

- `xorg-fonts-misc`
- `noto-fonts`, `noto-fonts-cjk`

```
xset fp default
xset fp rehash
```

## `/etc/systemd/journald.conf`

```
MaxLevelStore=notice
MaxLevelSyslog=notice
```

## `/etc/logrotate.d/...`

```
daily
dateext
minsize 1M
rotate 4
```

## `/boot/syslinux/syslinux.cfg`

```
LABEL arch
    MENU LABEL Arch Linux
    LINUX ../vmlinuz-linux
    APPEND ip=:::::eth0:dhcp cryptdevice=PARTUUID=<PARTUUID>:root:allow-discards root=/dev/mapper/root rw
    INITRD ../initramfs-linux.img
```

## `mkinitcpio.conf`

```
HOOKS=(... netconf hetzner tinyssh encryptssh filesystems ...)
```

## iptables

```
```

## nginx

## unbound

## bind

## mailu

## android

- <https://wiki.archlinux.org/index.php/Android>

```
yay -S android-studio
yay -S android-sdk android-sdk-platform-tools android-platform android-emulator
```

```
groupadd android-sdk
gpasswd -a "$USER" android-sdk

setfacl -R -m g:android-sdk:rwx /opt/android-sdk
setfacl -d -m g:android-sdk:rwX /opt/android-sdk
```

```
adb install "$APK"
```

## luks

```
# check block size
blockdev --getpbsz /dev/sda1

# luks with integrity
sudo cryptsetup luksFormat --type luks2 --integrity hmac-sha256 --sector-size 4096 /dev/sda1
```
