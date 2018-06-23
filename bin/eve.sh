#!/bin/sh
set -euf

export WINE_ROOT="$DISK_46A2/wine"

if [ $# -eq 0 ] ; then
    set -- "C:/Program Files (x86)/CCP/EVE/eve.exe"
fi

exec primusrun \
"$DOTFILES/bin/wine.sh" eve \
explorer /desktop=eve,1280x1024 \
"$@"
