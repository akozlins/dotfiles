#!/bin/sh
set -euf

export WINE="wineconsole --backend=user"
export WINEARCH=win32

if [ $# -ge 1 ] ; then
  wine.sh far "$@"
  exit 0
fi

exec \
"$DOTFILES/bin/wine.sh" far \
"C:/Program Files/Far/Far.exe"
