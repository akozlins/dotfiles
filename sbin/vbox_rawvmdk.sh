#!/bin/sh
set -euf -o pipefail

exec \
vboxmanage \
internalcommands createrawvmdk \
-filename $1 \
-rawdisk $2
