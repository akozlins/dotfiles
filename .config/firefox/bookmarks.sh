#!/bin/bash
set -euf

DIR=$(readlink -f -- "$0")
DIR=$(dirname -- "$DIR")
jsonlz4=$(find "$DIR/default/bookmarkbackups/" | sort -r | head -n 1)

jsonlz4.py -d "$jsonlz4" - | ./bookmarks.py | json2yaml.py > bookmarks.yaml
jsonlz4.py -d "$jsonlz4" - | ./bookmarks.py | jsonlz4.py -c - bookmarks.jsonlz4
