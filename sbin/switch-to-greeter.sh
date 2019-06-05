#!/bin/sh


if [ -n "$(pidof lightdm)" ] ; then
    exec dm-tool switch-to-greeter
fi

if [ -n "$(pidof lxdm-session)" ] ; then
    exec lxdm -c USER_SWITCH
fi

exit 1
