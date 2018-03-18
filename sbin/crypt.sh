#!/bin/sh
set -euf

if [ $# -lt 2 ] ; then
    echo "Usage crypt.sh <password> <salt>"
    exit 1
fi

password='"$'"$1"'"'
salt='"\$6\$'"$2"'\$"'

perl -e "print crypt($password, $salt)"
