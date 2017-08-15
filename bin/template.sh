#!/bin/sh
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")"

#set -o errexit
#set -o nounset
#IFS=$'\n\t'
