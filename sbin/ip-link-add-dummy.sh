#!/bin/bash
set -euf

if [ "$(id -u)" -ne 0 ] ; then
    exec sudo "$0" "$@"
fi

MYNAME=bond0
MYMAC=

while [[ $# -gt 0 ]] ; do
    case $1 in
    --name)
        shift
        MYNAME=$1
        shift
        ;;
    --mac)
        shift
        MYMAC=$1
        shift
        ;;
    --delete)
        ip link delete "$MYNAME" type dummy
        rmmod dummy
        exit 0
        ;;
    *)
        exit 1
    esac
done

modprobe dummy
ip link add "$MYNAME" type dummy

if [ -n "${MYMAC:+x}" ] ; then
    ifconfig "$MYNAME" hw ether "$MYMAC"
fi
