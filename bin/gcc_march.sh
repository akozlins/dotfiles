#!/bin/sh
set -eu -o pipefail

gcc -c -Q -march=native --help=target | grep march
rm -v help-dummy.o
