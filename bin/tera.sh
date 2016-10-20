#!/bin/sh
set -eu -o pipefail

export WINE_ROOT=/run/media/akozlins/4677801d-12d7-40d4-808b-f152e6273ba2/akozlins/wine
export WINEARCH=win32

if [ $# -ge 1 ]; then
  wine.sh tera "$@"
  exit 0
fi

primusrun ~/bin/wine.sh tera \
explorer /desktop=tera,1280x1024 \
"C:/users/Public/Games/En Masse Entertainment/TERA/TERA-Launcher.exe"
