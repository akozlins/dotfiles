#!/bin/sh
set -euf -o pipefail

export WINE_ROOT="$DISK_46A2/wine"

if [ $# -ge 1 ]; then
  wine.sh eve "$@"
  exit 0
fi

exec \
primusrun $DOTFILES/bin/wine.sh eve \
explorer /desktop=eve,1280x1024 \
"C:/Program Files (x86)/CCP/EVE/eve.exe"
