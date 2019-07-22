#!/bin/sh
set -euf

mnt=$1

# Install base

pacstrap $mnt base

# Time zone

ln -sfnv /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

# Locale

sed -i '/^#en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
sed -i '/^#en_US ISO-8859-1/s/^#//g' /etc/locale.gen

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

./pacman-init.sh

# fstab

dd if=/dev/zero of=/swap bs=1M count=512
chmod 600 /swap
mkswap /swap

./fstab.sh /dev/sda1

# ssh

mkdir -pv ~/.ssh
chmod go-rwx ~/.ssh
nano ~/.ssh/authorized_keys
