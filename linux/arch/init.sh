#!/bin/bash
set -euf

dev=$1
mnt=$2

read -p "Partition disk? y/[n]" -n 1 yn
case $yn in
    [Yy]* )
        ./gdisk.sh "$dev"
        ;;
    * ) ;;
esac



# mount file system

mount ${dev}2 "$mnt"
cleanup() {
    rv=$?
    umount -R "$mnt"
    exit $rv
}
trap cleanup EXIT
mkdir -p "$mnt/boot"
mount "${dev}1" "$mnt/boot"



read -p "Install packages? y/[n]" -n 1 yn
case $yn in
    [Yy]* )
        pacstrap "$mnt" base
        ;;
    * ) ;;
esac



./fstab.sh "$dev" | tee "$mnt/etc/fstab"

cp init-chroot.sh /mnt/
arch-chroot "$mnt" /init-chroot.sh
