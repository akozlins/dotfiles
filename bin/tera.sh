#!/bin/sh
set -euf

export WINE_ROOT="$DISK_46A2/wine"
export WINEARCH=win32

if [ $# -ge 1 ] ; then
  wine.sh tera "$@"
  exit 0
fi

exec \
primusrun "$DOTFILES/bin/wine.sh" tera \
explorer /desktop=tera,1280x1024 \
"C:/users/Public/Games/En Masse Entertainment/TERA/TERA-Launcher.exe"
