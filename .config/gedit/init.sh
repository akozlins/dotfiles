#!/bin/bash
set -euf

mkdir -p -- "$XDG_DATA_HOME/gedit/plugins"
cd "$XDG_DATA_HOME/gedit/plugins" || exit 1

git clone https://github.com/jefferyto/gedit-control-your-tabs
