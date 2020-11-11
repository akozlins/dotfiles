#!/bin/sh
set -euf

unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

find "$(pwd)" -name "*.in" | while read -r fin ; do
    fout=$(dirname -- "$fin")/$(basename -- "$fin" .in)
    echo "I [] envsubst > $fout"
    envsubst < "$fin" > "$fout"
done
