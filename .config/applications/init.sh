#!/bin/sh
set -euf

unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

APPS="$XDG_DATA_HOME/applications"
mkdir -pv -- "$APPS"

find "$(pwd)" -name "*.in" | while read -r fin ; do
    fout=$APPS/$(basename -- "$fin" .in)
    echo "I [] envsubst > $fout"
    envsubst < "$fin" > "$fout"
done
