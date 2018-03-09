#!/bin/sh
set -euf

unset CDPATH
cd "$(dirname -- "$(readlink -e -- "$0")")" || exit 1

#set -o errexit
#set -o nounset
#IFS=$'\n\t'
