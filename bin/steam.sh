#!/bin/sh
set -euf

export WINE_ROOT="$DISK_46A2/wine"
export WINEARCH=win32

if [ $# -ge 1 ] ; then
  wine.sh steam32 "$@"
  exit 0
fi

exec \
primusrun "$DOTFILES/bin/wine.sh" steam32 \
explorer /desktop=steam32,1280x1024 \
"C:/Program Files/Steam/Steam.exe" -no-dwrite
