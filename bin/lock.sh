#!/bin/sh
set -euf

if [ -x "/bin/xsecurelock" ] ; then
#    export XSECURELOCK_BLANK_DPMS_STATE=standby
    export XSECURELOCK_BLANK_TIMEOUT=1
    export XSECURELOCK_DATETIME_FORMAT=%FT%T
    export XSECURELOCK_SHOW_DATETIME=1
    exec /bin/xsecurelock
fi

if [ -n "$(pidof xscreensaver)" ] ; then
    exec xscreensaver-command -lock
fi

if [ -n "$(pidof light-locker)" ] ; then
    exec light-locker-command -l
fi

if [ -x "/bin/xdg-screensaver" ] ; then
    /bin/xdg-screensaver activate
fi

>&2 echo "E [$0] no known locker found or running"
exit 1
