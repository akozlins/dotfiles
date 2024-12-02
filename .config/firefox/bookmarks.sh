#!/bin/bash
set -euf

DIR="$DOTFILES/.mozilla/firefox"
jsonlz4=$(find "$DIR/default/bookmarkbackups/" | sort -r | head -n 1)

jsonlz4.py -d "$jsonlz4" - | ./bookmarks.py | json2yaml.py > bookmarks.yaml
jsonlz4.py -d "$jsonlz4" - | ./bookmarks.py | jsonlz4.py -c - bookmarks.jsonlz4
