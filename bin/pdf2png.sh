#!/bin/sh
set -euf

if [ "$#" -eq 2 ] ; then
    input="$1"
    output="$2"
elif [ "$#" -eq 1 ] ; then
    input="$1"
    output="$1.png"
else
    echo "usage: $0 <input> [output]"
    exit 1
fi

exec \
convert \
-define pdf:use-cropbox=true \
-density 150 \
"$input" "$output"
