#!/bin/sh
set -euf

curl -s "https://archlinux.org/mirrorlist/?country=DE&protocol=https&use_mirror_status=on" \
| sed -e 's/^#Server/Server/' -e '/^#/d' \
| rankmirrors -n 5 -
