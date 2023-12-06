#!/bin/bash
set -euf

VENV="${MY_PYTHON_VENV}/$1"

[ -f "$VENV/bin/activate" ] || python -m venv "$VENV"

cd "$VENV" || exit 1
#export HOME=$PWD
bash -c "source ./bin/activate && bash"
