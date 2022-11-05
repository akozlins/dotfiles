#!/bin/bash
set -euf

mkdir -p -- /etc/unbound/conf.d
envsubst < unbound.conf > /etc/unbound/conf.d/unbound.conf
echo 'include: "/etc/unbound/conf.d/*.conf"' >>  /etc/unbound/unbound.conf
touch -- /etc/unbound/unbound.log
chown unbound:unbound /etc/unbound/unbound.log
