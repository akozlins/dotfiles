#!/bin/bash
set -euf

# docker group or root
#[[ " $(id --groups --name) " =~ " docker " ]] || \
if [ "$(id -u)" -ne 0 ] ; then
    exec sudo "$0" "$@"
fi

# loop over containers
for c in $(docker container ls --format='{{.ID}}') ; do
    name=$(docker container inspect "$c" --format='{{.Name}}')
    # get upper dir location
    udir=$(docker container inspect "$c" --format='{{.GraphDriver.Data.UpperDir}}')
    echo "$name -> $udir"
    # and list its content
    ( cd "$udir" && du --max-depth=1 .)
done
