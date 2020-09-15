#!/bin/sh
set -euf

FILE="$HOME/.bash_history"

if [ ! -e "$FILE" ] ; then
     >&2 echo "E [$0] '$FILE' not found"
    exit 1
fi

cat "$FILE" | tac | awk '!x[$0]++' | tac
