#!/bin/bash
set -euf

KEY=$3

LUKS=$(find /dev/disk/by-uuid/ -maxdepth 1 -name "$1")
if [[ ${#LUKS[@]} > 1 ]] ; then
    exit 1
fi
udisksctl unlock --block-device "$LUKS" \
    --key-file "$KEY"

DISK=$(find /dev/disk/by-uuid/ -maxdepth 1 -name "$2")
if [[ ${#LUKS[@]} > 1 ]] ; then
    udisksctl lock --block-device "$LUKS"
    exit 1
fi
udisksctl mount --block-device "$DISK"
