#!/bin/sh
set -euf

if [ -z "${WINE_ROOT:+x}" ] ; then
    WINE_ROOT="$XDG_DATA_HOME/wine"
fi
export WINE_ROOT

if [ ! -d "$WINE_ROOT" ] ; then
    echo "ERROR: wine root '$WINE_ROOT' not found"
    exit 1
fi

export WINEPREFIX="$WINE_ROOT/$1"
shift

export WINEDEBUG=-all

export WINEDLLOVERRIDES="winemenubuilder.exe=d"

exec \
wine "$@"
