#!/bin/bash
set -euf

while true ; do
    printf "? [y,n,q] "
    # disable canonical input (ERASE and KILL processing)
    stty -icanon
    # see "POSIX / 11. General Terminal Interface / 11.1.7 Non-Canonical Mode Input Processing"
    # If ICANON is not set, read requests shall be satisfied directly from the input queue.
    sel=$(dd bs=1 count=1 2>/dev/null)
    stty icanon
    printf "\n"
    case "$sel" in
        y) exit 0 ;;
        n) exit 1 ;;
        q) exit 1 ;;
        *) continue ;;
    esac
done
