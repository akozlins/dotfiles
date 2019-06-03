#!/bin/sh
set -euf

dev=$1

boot=$(blkid -s PARTUUID -o value "${dev}1")

cat << EOF
/dev/mapper/root / ext4 rw,noatime,data=ordered 0 1

PARTUUID=$boot /boot vfat rw,noatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro 0 2

/swap none swap defaults 0 0
EOF
