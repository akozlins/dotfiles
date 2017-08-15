#!/bin/sh
set -euf

if [ "$#" -ne 2 ] ; then
  echo "usage: $0 command geometry"
  exit 1
fi

random=$(hexdump -n 8 -e '/8 "%X"' /dev/urandom)
#random=$(tr -cd "[:alnum:]" < /dev/urandom | head -c 16)
tmp="/tmp/uxterm_$$_$random"

/usr/bin/uxterm -geometry "$2" -e "echo ok > $tmp; $1" > /dev/null 2>&1 &

printf "wait for '%s'" "$tmp"
while [ ! -s "$tmp" ]
  do
  printf "."
  sleep 0.01
done
printf " [ok]\n"
rm -v "$tmp"
