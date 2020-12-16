#!/bin/sh
set -euf

jsonlz4="default/sessionstore-backups/recovery.jsonlz4"

#jsonlz4.py -d "$jsonlz4" | jq ".windows[].tabs[].entries[-1].url"

jsonlz4.py -d "$jsonlz4" - | ./tabs.py | jsonlz4.py -c - sessionstore.jsonlz4
