#!/bin/sh
set -euf
unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")"

if [ ! -d "far2l/.git" ] ; then
    git clone --depth 1 https://github.com/elfmz/far2l
    patch -p1 < far2l.patch
fi

cd far2l
git pull

mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j4
