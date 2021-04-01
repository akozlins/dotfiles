#!/bin/sh
set -euf

jsonlz4=$(find "default/bookmarkbackups/" | sort | tail -n 1)

jsonlz4.py -d "$jsonlz4" - | ./bookmarks.py | json2yaml.py > bookmarks.yaml
jsonlz4.py -d "$jsonlz4" - | ./bookmarks.py | jsonlz4.py -c - bookmarks.jsonlz4
