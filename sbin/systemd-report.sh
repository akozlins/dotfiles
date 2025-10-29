#!/bin/bash
set -euf

units=(
    $(systemctl --type=service | awk '{ if($3=="active") print $1 }')
)

echo "restarts:"
for u in "${units[@]}" ; do
    #n=$(systemctl show "$u" -p NRestarts)
    #n=${n#NRestarts=}
    n=$(journalctl -b -u $u | grep -c Started | cat )
    [[ $n > 1 ]] || continue
    echo $u $n
done

units=(
    $(systemctl --type=service | awk '{ if($3=="failed") print $1 }')
)

echo "failed:"
for u in "${units[@]}" ; do
    echo $u -1
done
