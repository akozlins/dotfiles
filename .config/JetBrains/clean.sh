#!/bin/sh
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

set -x

git clean -Xdf -- .

( cd "$DOTFILES/.java" || exit 1 ; git clean -Xdf -- . )

rm -rfv -- "$XDG_CACHE_HOME/JetBrains"
rm -rfv -- "$XDG_DATA_HOME/JetBrains"
