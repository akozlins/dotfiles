#!/bin/sh
set -euf -o pipefail
cd $(dirname `readlink -f $0`)

if [[ ! -d fbpanel ]] ; then
    git clone --depth 1 https://github.com/aanatoly/fbpanel
fi

cd fbpanel
git pull
git reset --hard

sed -i 's|python|python2|' configure .config/{repl.py,help,tar.py}
git apply ../fbpanel.patch
./configure --prefix=$HOME/.local
make
make install
