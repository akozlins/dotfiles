#/bin/sh
set -euf

cat /etc/unbound/unbound.log | awk '{ if($6=="A" && $10==0) print $1 " " $5 " " $9; }' | column -t

cat /etc/unbound/unbound.log | awk '{ if($6=="A" && $10==0) print $5; }' | sort | uniq -c | sort -r -n | head
