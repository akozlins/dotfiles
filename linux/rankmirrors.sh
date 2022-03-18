#!/bin/sh
set -euf

COUNTRY=DE

curl -s "https://archlinux.org/mirrorlist/?country=$COUNTRY&protocol=https&use_mirror_status=on" \
| sed -e 's/^#Server/Server/' -e '/^#/d' \
| rankmirrors -n 5 -
