#!/bin/sh
set -euf

export WINE="wineconsole --backend=user"
export WINEARCH=win32

if [ $# -eq 0 ] ; then
    set -- "C:/Program Files/Far/Far.exe"
fi

exec \
"$DOTFILES/bin/wine.sh" far \
    "$@"
