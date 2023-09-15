#!/bin/bash
set -euf

# root
if [ "$(id -u)" -ne 0 ] ; then
    exec sudo "$0" "$@"
fi

exec \
iptables -nvL \
| awk '
($3 == "(policy" && "DROP" == $4 && $5 != "0") {
    print $0
}
($1 != "0" && $3 == "ACCEPT" && $6 != $7) {
    print $0
}
($1 != "0" && $3 == "DROP") {
    print $0
}
($1 != "0" && $3 == "REJECT") {
    print $0
}
'
