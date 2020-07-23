#!/bin/sh
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -e -- "$0")")" || exit 1

dconf load / < root.dump
