#!/bin/sh
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")"

if [ ! "$(id -u)" = "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! -d package-query ] ; then
    git clone https://aur.archlinux.org/package-query.git
    ( cd package-query; makepkg -s; )
fi

if [ ! -d yaourt ] ; then
    git clone https://aur.archlinux.org/yaourt.git
    ( cd yaourt; makepkg -s; )
fi
