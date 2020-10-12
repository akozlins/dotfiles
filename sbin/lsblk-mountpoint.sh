#!/bin/sh
set -euf

if [ $# -eq 0 ] ; then
    for i in $(ls -1 /dev/disk/by-uuid) ; do
        echo "$i" $(lsblk --noheadings --output MOUNTPOINT -- "/dev/disk/by-uuid/$i")
    done
    exit 0
fi
