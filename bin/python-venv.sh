#!/bin/bash
set -euf

VENV="${MY_PYTHON_VENV:-$XDG_CACHE_HOME/venv}/$1"

[ -f "$VENV/bin/activate" ] || python -m venv "$VENV"

#pip list --outdated --format=json \
#| jq -r '.[] | .name' \
#| xargs --no-run-if-empty pip install --upgrade
#pip install ...

cd "$VENV" || exit 1
#export HOME=$PWD
bash -c "source ./bin/activate && bash"
