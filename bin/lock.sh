#!/bin/sh
set -euf

if [ -n "$(pidof /usr/bin/xscreensaver)" ] ; then
    exec xscreensaver-command -lock
fi

if [ -n "$(pidof /usr/bin/light-locker)" ] ; then
    exec light-locker-command -l
fi

if [ -e "/usr/bin/xsecurelock" ] ; then
    export XSECURELOCK_BLANK_TIMEOUT=1
    exec /usr/bin/xsecurelock
fi

exit 1
