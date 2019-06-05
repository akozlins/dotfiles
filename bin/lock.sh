#!/bin/sh
set -euf

if [ -n "$(pidof /usr/bin/xscreensaver)" ] ; then
    exec xscreensaver-command -lock
fi

if [ -n "$(pidof /usr/bin/light-locker)" ] ; then
    exec light-locker-command -l
fi

exit 1
