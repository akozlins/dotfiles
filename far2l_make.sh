#!/bin/sh
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")"

if [ ! -d "far2l/.git" ] ; then
    git clone --depth 1 https://github.com/elfmz/far2l
fi

git -C far2l stash
git -C far2l pull
patch -p0 < far2l.patch

mkdir -p far2l/build
cd far2l/build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j4
