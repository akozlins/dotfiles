#!/bin/sh
set -euf

DIR=$(readlink -f -- "$0")
DIR=$(dirname -- "$DIR")
jsonlz4="$DIR/default/sessionstore-backups/recovery.jsonlz4"

#jsonlz4.py -d "$jsonlz4" | jq ".windows[].tabs[].entries[-1].url"

jsonlz4.py -d "$jsonlz4" - | ./tabs.py | json2yaml.py > sessionstore.yaml
jsonlz4.py -d "$jsonlz4" - | ./tabs.py | jsonlz4.py -c - sessionstore.jsonlz4
