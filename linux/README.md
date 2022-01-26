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

```
# terminal bitmap fonts
pacman -S xorg-fonts-misc
# ...
pacman -S noto-fonts noto-fonts-cjk
# reset xorg font cache
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

## iptables

```
```

## nginx

## unbound

## bind

```
nano /var/named/example.com.zone`
```

## mailu

## maddy

```
sudo setfacl -R -m u:maddy:rX /etc/letsencrypt/{live,archive}
maddyctl creds create postmaster@example.com
maddyctl imap-acct create postmaster@example.com
```

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

## virtualbox

```
modprobe nbd
qemu-nbd -c /dev/nbd0 disk.vdi
mount /dev/nbd0p1 /mnt
umount /mnt
qemu-nbd -d /dev/nbd0
```
