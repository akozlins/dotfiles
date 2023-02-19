#!/bin/bash
set -euf

sync

DISK=$(find /dev/disk/by-uuid/ -maxdepth 1 -name "$2")
if [[ ${#LUKS[@]} > 1 ]] ; then
    exit 1
fi
udisksctl unmount --block-device $MOUNT

LUKS=$(find /dev/disk/by-uuid/ -maxdepth 1 -name "$1")
if [[ ${#LUKS[@]} > 1 ]] ; then
    exit 1
fi
udisksctl lock --block-device $LUKS
udisksctl power-off --block-device $LUKS
