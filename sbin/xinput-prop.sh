#!/bin/sh
set -euf

DEVICE="$1"

while IFS='' read -r name ; do
    id=$(xinput --list --id-only "$name")
    echo "id='$id', name='$name'"

    if [ $# -lt 2 ] ; then
        continue
    fi

    PROP="$2"
    while IFS='' read -r prop ; do
#        value=$(echo "$prop" | awk '{ match($0, /[^:]+$/); if(RSTART) print substr($0, RSTART, RLENGTH); }')
#        prop=$(echo "$prop" | awk '{ match($0, /\([0-9]+\)/); if(RSTART) print substr($0, RSTART+1, RLENGTH-2); }')
        echo "$prop"
    done < <(xinput list-props "$id" | grep -i "$PROP")
done < <(xinput --list --name-only | grep -i "$DEVICE")
