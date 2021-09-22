#!/bin/sh
set -euf

if [ -x "/usr/bin/xsecurelock" ] ; then
#    export XSECURELOCK_BLANK_DPMS_STATE=standby
    export XSECURELOCK_BLANK_TIMEOUT=1
    exec /usr/bin/xsecurelock
fi

if [ -n "$(pidof xscreensaver)" ] ; then
    exec xscreensaver-command -lock
fi

if [ -n "$(pidof light-locker)" ] ; then
    exec light-locker-command -l
fi

>&2 echo "E [$0] no known locker found or running"
exit 1
