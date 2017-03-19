#!/bin/sh
set -euf -o pipefail

export WINE_ROOT=/run/media/akozlins/4677801d-12d7-40d4-808b-f152e6273ba2/akozlins/wine
export WINEARCH=win32

if [ $# -ge 1 ]; then
  wine.sh steam32 "$@"
  exit 0
fi

primusrun ~/bin/wine.sh steam32 \
explorer /desktop=steam32,1280x1024 \
"C:/Program Files/Steam/Steam.exe" -no-dwrite
