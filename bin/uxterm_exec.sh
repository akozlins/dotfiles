#!/bin/bash
set -euf

if [ $# -ne 2 ] ; then
    echo "usage: $0 <geometry> <command>"
    exit 1
fi

umask 077
tmp=$(mktemp)
cleanup() {
    rc=$?
    rm -fv -- "$tmp"
    exit $rc
}
trap cleanup EXIT

geometry=$1
command="rm -fv -- '$tmp' ; $2"

/bin/uxterm -geometry "$geometry" -e /bin/sh -c "$command" > /dev/null 2>&1 &

printf "wait for '%s' " "$tmp"
while [ -f "$tmp" ] ; do
    printf "."
    sleep 0.1
done
printf " [ok]\\n"
