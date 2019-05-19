#!/bin/sh
set -euf
IFS="$(printf '\n\t')"
unset CDPATH
cd "$(dirname -- "$(readlink -e -- "$0")")" || exit 1

#set -o errexit -o nounset
