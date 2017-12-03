#!/bin/sh
set -euf

# https://wiki.archlinux.org/index.php/DNSCrypt

if id -u dnscrypt ; then
    # TODO: error message
    exit 1
fi
useradd -r -d /var/dnscrypt -m -s /sbin/nologin dnscrypt

cat << EOF > /etc/dnscrypt-proxy.conf
User dnscrypt
ResolverName dnscrypt.eu-nl
EOF
