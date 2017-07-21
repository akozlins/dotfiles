#!/bin/sh
set -euf -o pipefail
cd $(dirname `readlink -f $0`)

if [[ ! -d "fbpanel/.git" ]] ; then
    git clone --depth 1 https://github.com/aanatoly/fbpanel
#    sed -i 's|python|python2|' configure fbpanel/.config/{repl.py,help,tar.py}
    patch -p1 < fbpanel.patch
fi

cd fbpanel
git pull

./configure --prefix=$HOME/.local
make
make install
