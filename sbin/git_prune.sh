#!/bin/sh
set -eu

git submodule foreach 'git gc --prune="0 days"'
git gc --prune="0 days"
