#!/bin/sh
set -eu -o pipefail

export WINE_ROOT=/run/media/akozlins/4677801d-12d7-40d4-808b-f152e6273ba2/akozlins/wine

if [ $# -ge 1 ]; then
  wine.sh eve "$@"
  exit 0
fi

primusrun wine.sh eve \
explorer /desktop=steam,1280x1024 \
"C:/Program Files (x86)/CCP/EVE/eve.exe"
