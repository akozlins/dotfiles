#!/bin/sh
set -euf -o pipefail
unset CDPATH
cd "$(dirname `readlink -f $0`)"

#set -o errexit
#set -o nounset
#set -o pipefail
#IFS=$'\n\t'
