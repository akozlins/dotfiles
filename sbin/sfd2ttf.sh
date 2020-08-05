#!/bin/sh
set -euf

fontforge -lang=ff -c "Open(\$1); Generate(\$2)" "$1" "$2"
