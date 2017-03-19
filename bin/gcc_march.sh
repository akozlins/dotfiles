#!/bin/sh
set -euf -o pipefail

/usr/bin/gcc -c -Q -march=native --help=target -o /dev/null | grep march
