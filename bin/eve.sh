#!/bin/sh
set -euf -o pipefail

export WINE_ROOT=/run/media/akozlins/4677801d-12d7-40d4-808b-f152e6273ba2/akozlins/wine

if [ $# -ge 1 ]; then
  wine.sh eve "$@"
  exit 0
fi

primusrun $DOTFILES/bin/wine.sh eve \
explorer /desktop=eve,1280x1024 \
"C:/Program Files (x86)/CCP/EVE/eve.exe"
