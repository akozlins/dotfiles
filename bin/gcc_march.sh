#!/bin/sh
set -euf

exec \
/bin/gcc -c -Q -march=native --help=target -o /dev/null | grep march
