#!/bin/bash

my_stopwatch() {
    t1=$(date --utc +%s)
    while true ; do
        t2=$(date --utc +%s)
        dt=$((t2-t1))
        printf "\r%s" "$(date --utc --date=@$dt +%T)"
        [ -n "$1" ] && [ "$dt" -ge "$1" ] && break
        sleep 0.1
    done
    printf "\n"
}

my_pacman_diff() {
    pkg=$(pacman -Qo "$1" | awk '// { printf "%s-%s", $(NF-1), $NF }')
    file=$(echo "$1" | sed 's|^/||')
    tar --extract --to-stdout --file="/var/cache/pacman/pkg/${pkg}-$(uname -m).pkg.tar.zst" "$file" | diff - "$1"
}
