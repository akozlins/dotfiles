#!/bin/bash
set -eu

if [ $# -eq 0 ] ; then
    disks=(/dev/disk/by-uuid/*)
    for disk in "${disks[@]}" ; do
        uuid=$(basename "$disk")
        mount=$(lsblk --noheadings --output MOUNTPOINT -- "$disk")
        echo "$uuid" "$mount"
    done
    exit 0
fi
