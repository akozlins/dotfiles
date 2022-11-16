#!/bin/bash
set -euf

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
WINE_ROOT="${WINE_ROOT:-$XDG_DATA_HOME/wine}"
if [ ! -d "$WINE_ROOT" ] ; then
    >&2 echo "E [$0] wine root '$WINE_ROOT' not found"
    exit 1
fi
export WINE_ROOT

export WINEPREFIX="$WINE_ROOT/$1"
shift

export WINEDEBUG=-all

export WINEDLLOVERRIDES="winemenubuilder.exe=d"

exec \
${WINE:-wine} "$@"
