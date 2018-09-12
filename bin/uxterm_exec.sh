#!/bin/sh
set -euf

if [ $# -ne 2 ] ; then
  echo "usage: $0 geometry program"
  exit 1
fi

tmp=$(mktemp)
cleanup() {
    rv=$?
    rm -rf -- "$tmp"
    exit $rv
}
trap "cleanup" EXIT

geometry=$1
program="rm -f -- '$tmp' ; $2"

/usr/bin/uxterm -geometry "$geometry" -e "sh -c '$program'" > /dev/null 2>&1 &

printf "wait for '%s' " "$tmp"
while [ -f "$tmp" ] ; do
    printf "."
    sleep 0.01
done
printf " [ok]\\n"
