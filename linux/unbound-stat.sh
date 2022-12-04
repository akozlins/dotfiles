#/bin/sh
set -euf

# /etc/unbound/unbound.log
# - $1 - timestamp
# - $5 - name
# - $6 - type
# - $9 - time to resolve
# - $10 - from cache

# print forwarded requests
#cat /etc/unbound/unbound.log | awk '{ if($6=="A" && $10==0) print $1 " " $5 " " $9; }' | column -t

# freq list
tail -n 100000 /etc/unbound/unbound.log \
| awk '
($3 == "info:") {
    qname = $5
    cached = $10
    n[qname] += 1;
    f[qname] += !cached;
}
END {
    for(qname in n) {
        print n[qname],f[qname],qname;
    }
}
' \
| sort -r -n | head -n 100 | column -t
