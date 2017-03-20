#!/bin/sh
set -euf -o pipefail

: ${WINE_ROOT="/home/akozlins/wine"}

if [ ! -d "$WINE_ROOT" ]; then
  echo ERROR: wine root "$WINE_ROOT" not found
  exit 1
fi

export WINEPREFIX=$WINE_ROOT/$1
shift
#echo WINEPREFIX = WINEPREFIX

#echo WINEARCH = ${WINEARCH:-}

export WINEDEBUG=-all
#echo WINEDEBUG = WINEDEBUG

export WINEDLLOVERRIDES=winemenubuilder.exe=d

exec \
${WINE:-wine} "$@" \
&> /dev/null &
