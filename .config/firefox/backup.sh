#!/bin/bash
set -euf

FIREFOX="$XDG_CONFIG_HOME/firefox"
PROFILE="$XDG_CACHE_HOME/firefox/default"



sessionstore="$PROFILE/sessionstore-backups/recovery.jsonlz4"
jsonlz4.py -d "$sessionstore" - | "$FIREFOX/tabs.py" | jq . > "sessionstore.json.$(hostname)"

LAST=$(find . -name "sessionstore.json.$(hostname).*" | sort -r | head -n 1)
if ! diff "sessionstore.json.$(hostname)" "$LAST" > /dev/null 2>&1 ; then
    cp "sessionstore.json.$(hostname)" "sessionstore.json.$(hostname).$(date +%FT%T)"
fi



bookmarks=$(find "$PROFILE/bookmarkbackups/" -name "*.jsonlz4" | sort -r | head -n 1)
jsonlz4.py -d "$bookmarks" - | "$FIREFOX/bookmarks.py" | jq . > "bookmarks.json.$(hostname)"

LAST=$(find . -name "bookmarks.json.$(hostname).*" | sort -r | head -n 1)
if ! diff "bookmarks.json.$(hostname)" "$LAST" > /dev/null 2>&1 ; then
    cp "bookmarks.json.$(hostname)" "bookmarks.json.$(hostname).$(date +%FT%T)"
fi
