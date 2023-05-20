#!/bin/sh

my_stopwatch () {
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
