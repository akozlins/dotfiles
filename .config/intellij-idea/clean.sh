#!/bin/sh
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -e -- "$0")")" || exit 1

git clean -Xdf -- .

rm -rf -- "$HOME/.java"
rm -rf -- "$XDG_CACHE_HOME/intellij-idea"
