#!/bin/sh
set -euf

unset CDPATH
cd "$(dirname -- "$(readlink -e -- "$0")")" || exit 1

profile="$1"
if [ ! -d "$profile" ] ; then
    echo "profile not found: $profile"
    exit 1
fi

dbs="
    firegestures
    extension-data/ublock0
    extension-data/umatrix
"

for db in $dbs ; do
    if [ ! -f "$profile/$db.sqlite" ] ; then
        sqlite3 "$profile/$db.sqlite" < "$profile/$db.sqlite.dump"
    else
        echo "already exists: $profile/$db.sqlite"
    fi
done

#sqlite3 places.sqlite "VACUUM;"
