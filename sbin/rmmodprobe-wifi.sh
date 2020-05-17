#!/bin/sh
set -euf

if [ "$(id -u)" -ne 0 ] ; then
    exec sudo "$0" "$@"
fi

# reload wifi modules
modprobe -v -r iwldvm
modprobe -v iwlwifi
