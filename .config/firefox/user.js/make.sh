#!/bin/sh
set -euf

unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

cp ../default/user.js ../default/user.$(date +%FT%T).js
./make.js > ../default/user.js
