#!/bin/sh
set -euf

dev=$1

(
echo o ; echo y ;
echo n ; echo 1 ; echo ; echo +256M ; echo ef00 ;
echo n ; echo 2 ; echo ; echo       ; echo      ;
echo w ; echo y ;
echo q ;
) | gdisk "$dev"

mkfs.vfat "${dev}1"
mkfs.ext4 "${dev}2"
