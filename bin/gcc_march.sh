#!/bin/sh
set -eu -o pipefail

/usr/bin/gcc -c -Q -march=native --help=target -o /dev/null | grep march
