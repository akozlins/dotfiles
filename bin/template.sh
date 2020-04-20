#!/bin/sh
set -euf
#set -o errexit -o nounset

IFS="$(printf '\n\t')"
unset CDPATH
cd "$(dirname -- "$(readlink -e -- "$0")")" || exit 1

PATH="$(getconf PATH)"
export PATH

#export HOME="$DOTFILES"

exec \
true "$@"
