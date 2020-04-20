#!/bin/sh
set -euf

if [ $# -lt 2 ] ; then
    echo "Usage crypt.sh <password> <salt>"
    exit 1
fi

password=$1
salt=$2

cmd=$(printf 'print crypt("%s", "\$6\$%s\$")' "$password" "$salt")

exec \
perl -e "$cmd"
