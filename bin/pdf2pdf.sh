#!/bin/sh
set -euf

if [ $# -eq 2 ] ; then
    input="$1"
    output="$2"
elif [ $# -eq 1 ] ; then
    input="$1~"
    output="$1"
    if [ -f "$input" ] ; then
        exit 1
    fi
    mv "$output" "$input"
else
    echo "usage: $0 input [output]"
    exit 1
fi

exec \
gs \
-sDEVICE=pdfwrite \
-dPDFSETTINGS=/prepress \
-dCompatibilityLevel=1.5 \
-o "$output" "$input"
