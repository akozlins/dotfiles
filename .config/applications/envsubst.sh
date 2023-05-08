#!/bin/sh

#EOF=EOF_$RANDOM
EOF=EOF_ENVSUBST

while read -r line ; do
   eval "cat << $EOF
$line
$EOF
"
done < /dev/stdin
