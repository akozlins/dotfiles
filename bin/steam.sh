#!/bin/sh
set -euf

export WINE_ROOT="$DISK_46A2/wine"
export WINEARCH=win32

if [ $# -eq 0 ] ; then
    set -- "C:/Program Files/Steam/Steam.exe" -no-dwrite
fi

exec primusrun \
"$DOTFILES/bin/wine.sh" steam32 \
explorer /desktop=steam32,1280x1024 \
"$@"
