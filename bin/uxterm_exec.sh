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
    rm -f -- "$tmp"
    exit $rc
}
trap cleanup EXIT

geometry=$1
command="rm -f -- '$tmp' ; $2"

/usr/bin/uxterm -geometry "$geometry" -e /bin/sh -c "$command" > /dev/null 2>&1 &

printf "wait for '%s' " "$tmp"
while [ -f "$tmp" ] ; do
    printf "."
    sleep 0.1
done
printf " [ok]\\n"
