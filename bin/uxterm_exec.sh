#!/bin/sh
set -euf

if [ $# -lt 2 ] ; then
  echo "usage: $0 geometry program [arguments...]"
  exit 1
fi

tmp=$(mktemp)
trap "{ rm -f $tmp ; exit 1 }" EXIT

geometry=$1
shift
program="rm -f $tmp ; $@"

/usr/bin/uxterm -geometry "$geometry" -e "$program" > /dev/null 2>&1 &

printf "wait for '%s' " "$tmp"
while [ -f "$tmp" ] ; do
    printf "."
    sleep 0.01
done
printf " [ok]\\n"
