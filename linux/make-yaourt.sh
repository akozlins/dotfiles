#!/bin/sh
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

if [ ! "$(id -u)" = "0" ] ; then
    >&2 echo "This script must be run as root"
    exit 1
fi

if [ ! -d package-query ] ; then
    git clone https://aur.archlinux.org/package-query.git
    ( cd package-query && makepkg -s )
fi

if [ ! -d yaourt ] ; then
    git clone https://aur.archlinux.org/yaourt.git
    ( cd yaourt && makepkg -s )
fi
