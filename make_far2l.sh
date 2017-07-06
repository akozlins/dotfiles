#!/bin/sh
set -euf -o pipefail
cd $(dirname `readlink -f $0`)

if [[ ! -d far2l ]] ; then
    git clone --depth 1 https://github.com/elfmz/far2l
fi

cd far2l
git pull

mkdir -p build
cd build
cmake ..
make
