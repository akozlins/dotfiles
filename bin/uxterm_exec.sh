#!/bin/sh
set -eu -o pipefail

if [ "$#" -ne 2 ] ; then
  echo "usage: $0 command geometry"
  exit 1
fi

tmp="/tmp/test_$$_$RANDOM"

/usr/bin/uxterm -geometry $2 -e "echo ok > $tmp; $1" &> /dev/null &

printf "wait for '$tmp' "
while [ ! -s $tmp ]
  do
  printf "."
  sleep 0.01
done
printf " [ok]\n"
rm -v $tmp
