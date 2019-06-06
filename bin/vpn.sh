#!/bin/sh
set -euf

if [ $# -ge 1 ] ; then
    HOST=$1
fi

if [ -z "${HOST:+x}" ] ; then
    HOST=$(hostname)
fi

service=openvpn-client@$HOST

if systemctl -q is-active "$service" ; then
    echo "Stop service '$service'"
    kdesu -n -c "systemctl stop $service"
else
    echo "Start service '$service'"
    kdesu -n -c "systemctl start $service"
fi
