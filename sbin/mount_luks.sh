#!/bin/bash
set -euf

LUKS_UUID="$1"
LUKS_NAME="luks-$LUKS_UUID"
sudo cryptsetup open --allow-discards "/dev/disk/by-uuid/$LUKS_UUID" "luks-$LUKS_UUID"

FS_UUID="$2"
sudo fsck.ext4 "/dev/disk/by-uuid/$FS_UUID"
sudo mkdir -p -- "/run/media/$USER/$FS_UUID"
sudo mount -o "rw,noatime,discard" "/dev/disk/by-uuid/$FS_UUID" "/run/media/$USER/$FS_UUID"
