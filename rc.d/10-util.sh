#!/bin/bash

my_stopwatch () {
    t1=$(date --utc +%s)
    while true ; do
        t2=$(date --utc +%s)
        dt=$((t2-t1))
        printf "\r%s" "$(date --utc --date=@$dt +%T)"
        [ -n "$1" ] && [ "$dt" -ge "$1" ] && break
        sleep 0.1
    done
    printf "\n"
}

my_mount_luks_fs () {
    LUKS_UUID="$1"
    LUKS_NAME="luks-$LUKS_UUID"
    sudo cryptsetup open --allow-discards "/dev/disk/by-uuid/$LUKS_UUID" "luks-$LUKS_UUID"

    FS_UUID="$2"
    sudo fsck.ext4 "/dev/disk/by-uuid/$FS_UUID"
    sudo mkdir -p -- "/run/media/$USER/$FS_UUID"
    sudo mount -o "rw,noatime,discard" "/dev/disk/by-uuid/$FS_UUID" "/run/media/$USER/$FS_UUID"
}
