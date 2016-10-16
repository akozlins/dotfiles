#!/bin/sh
set -eu -o pipefail

: ${WINE_ROOT="/home/akozlins/wine"}

if [ ! -d "$WINE_ROOT" ]; then
  echo ERROR: wine root "$WINE_ROOT" not found
  exit 1
fi

export WINEPREFIX=$WINE_ROOT/$1
export WINEDEBUG=-all

echo WINEPREFIX = WINEPREFIX
echo WINEARCH = ${WINEARCH:-}
echo WINEDEBUG = WINEDEBUG

export WINEDLLOVERRIDES=winemenubuilder.exe=d

shift
${WINE:-wine} "$@" \
&> /dev/null &
