#!/bin/bash
set -euf

# root
if [ "$(id -u)" -ne 0 ] ; then
    exec sudo "$0" "$@"
fi

exec \
iptables -nvL \
| awk '
# report policy DROP
($3 == "(policy" && "DROP" == $4 && $5 != "0") {
    print $0
}

# skip 0 packets/bytes
($1 == "0") { next }
# skip ACCEPT on same interface
($3 == "ACCEPT" && $6 == $7) { next }

($3 == "ACCEPT" || $3 == "DROP" || $3 == "LOG" || $3 == "REJECT") {
    print $0
}
'
