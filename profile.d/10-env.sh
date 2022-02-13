#!/bin/sh

set -a # set export attribute for each variable assignment
if false && [ -d "$XDG_CONFIG_HOME/environment.d" ] ; then
    for conf in $(ls "$XDG_CONFIG_HOME/environment.d"/*.conf) ; do
        . "$conf"
    done
fi
set +a
