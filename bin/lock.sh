#!/bin/sh
set -euf

if [ ! -z "$(pidof /usr/bin/xscreensaver)" ] ; then
    exec xscreensaver-command -lock
fi

exit 1
