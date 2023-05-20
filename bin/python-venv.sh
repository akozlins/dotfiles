#!/bin/bash
set -euf

mkdir -p -- "$XDG_CACHE_HOME/venv"
python -m venv "$XDG_CACHE_HOME/venv/$1"
cd "$XDG_CACHE_HOME/venv/$1" || exit 1

bash -c "source ./bin/activate && bash"
