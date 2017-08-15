#!/bin/sh
set -euf

exec \
/usr/bin/gcc -c -Q -march=native --help=target -o /dev/null | grep march
