#!/bin/sh
set -euf

dev=$1
mnt=$2

./arch/gdisk.sh "$dev"
mkfs.vfat "${dev}1"
mkfs.ext4 "${dev}2"

cleanup() {
    umount -R "$mnt"
    exit 0
}
trap cleanup EXIT
mount ${dev}2 "$mnt"
mkdir -p "$mnt/boot"
mount "${dev}1" "$mnt/boot"

# Install base

pacstrap -c "$mnt" base
arch-chroot "$mnt"

# Time zone

ln -sfnv /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

# Locale

sed -i '/^#en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
sed -i '/^#en_US ISO-8859-1/s/^#//g' /etc/locale.gen
sed -i '/^#en_GB.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
sed -i '/^#en_GB ISO-8859-1/s/^#//g' /etc/locale.gen

locale-gen

cat > /etc/locale.conf << EOF
LANG=en_US.UTF-8
LC_COLLATE=C
EOF

# Hostname

cat > /etc/hostname << EOF
local
EOF

# pacman

#./pacman-init.sh

# fstab

dd if=/dev/zero of=/swap bs=1M count=512
chmod 600 /swap
mkswap /swap

./fstab.sh "$dev" | tee "$mnt/etc/fstab"

# ssh

mkdir -pv ~/.ssh
chmod go-rwx ~/.ssh
nano ~/.ssh/authorized_keys
