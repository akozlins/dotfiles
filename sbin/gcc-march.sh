#!/bin/sh
set -euf

exec \
gcc -c -Q -march=native --help=target -o /dev/null | grep march
