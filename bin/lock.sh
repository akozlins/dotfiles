#!/bin/sh
set -euf

if [ -x "/usr/bin/xsecurelock" ] ; then
    export XSECURELOCK_BLANK_TIMEOUT=1
    exec /usr/bin/xsecurelock
fi

if [ -n "$(pidof /usr/bin/xscreensaver)" ] ; then
    exec xscreensaver-command -lock
fi

if [ -n "$(pidof /usr/bin/light-locker)" ] ; then
    exec light-locker-command -l
fi

exit 1
