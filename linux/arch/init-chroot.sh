#!/bin/bash
set -euf



# time

ln -vsf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime



# locale

sed -i '/^#en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
sed -i '/^#en_US ISO-8859-1/s/^#//g' /etc/locale.gen
sed -i '/^#en_GB.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
sed -i '/^#en_GB ISO-8859-1/s/^#//g' /etc/locale.gen

locale-gen

cat > /etc/locale.conf << EOF
LANG=en_US.UTF-8
LC_COLLATE=C
EOF



# hostname

cat > /etc/hostname << EOF
arch
EOF



# swap

if [ ! -e /swap ] ; then
    dd if=/dev/zero of=/swap bs=1M count=512
    chmod 600 /swap
    mkswap /swap
fi



# ssh

mkdir "$HOME/.ssh"
touch "$HOME/.ssh/authorized_keys"
chmod go-rwx "$HOME/.ssh"



# pacman

pacman-key --init
pacman-key --populate archlinux
pacman -Sy
