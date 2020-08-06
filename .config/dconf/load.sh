#!/bin/sh
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

dconf load / < root.dump
