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
tail -n 10000 /etc/unbound/unbound.log \
| awk '{ n[$5] += 1; f[$5] += ($10==0); } END { for(k in n) print n[k],f[k],k }' \
| sort -r -n | head -n 100 | column -t
