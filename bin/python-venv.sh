#!/bin/bash
set -euf

python -m venv "$XDG_CACHE_HOME/venv/$1"
cd "$XDG_CACHE_HOME/venv/$1" || exit 1

bash -c "source ./bin/activate && bash"
