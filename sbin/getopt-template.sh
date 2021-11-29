#!/bin/bash
set -euf

! getopt --test > /dev/null
if [[ "${PIPESTATUS[0]}" -ne 4 ]] ; then
    >&2 echo "E [$0] getopt is not the enchanced version"
    exit 1
fi

OPTIONS="hvo:"
LONGOPTIONS="help,verbose,output:"
h=0 v=0 o=-

! OPTS=$(getopt --options="$OPTIONS" --longoptions="$LONGOPTIONS" --name="$0" -- "$@")
if [[ "${PIPESTATUS[0]}" -ne 0 ]] ; then
    exit 1
fi

eval set -- "$OPTS"

while true ; do case "$1" in
    -h|--help) shift ; ((++h)) ;;
    -v|--verbose) shift ; ((++v)) ;;
    -o|--output) shift ; o="$1" ; shift ;;
    --) shift ; break ;;
    *) exit 1 ;;
esac done

echo "h=$h"
echo "v=$v"
echo "o=$o"
