#!/bin/sh
set -euf

export WINE_ROOT="$DISK_46A2/wine"
export WINEARCH=win32

if [ $# -eq 0 ] ; then
    set -- "C:/users/Public/Games/En Masse Entertainment/TERA/TERA-Launcher.exe"
fi

exec primusrun \
"$DOTFILES/bin/wine.sh" tera \
explorer /desktop=tera,1280x1024 \
"$@"
