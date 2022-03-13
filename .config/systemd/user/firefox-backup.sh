#!/bin/bash
set -eu

source ~/.profile
FIREFOX="$DOTFILES/.config/firefox"
PROFILE="$DOTFILES/.mozilla/firefox/default"

COMMIT=0

sessionstore="$PROFILE/sessionstore-backups/recovery.jsonlz4"
if [ -r "$sessionstore" ] ; then
    OUT=$(jsonlz4.py -d "$sessionstore" - | "$FIREFOX/tabs.py" | jq .)
    if ! diff -q "sessionstore.json" <(echo "$OUT") ; then
        echo "$OUT" > "sessionstore.json"
#        jsonlz4.py -c "sessionstore.json" "sessionstore.jsonlz4"
        [ -d ".git" ] && git add "sessionstore.json"
        COMMIT=1
    fi
fi

bookmarks=$(find "$PROFILE/bookmarkbackups/" -name "*.jsonlz4" | sort -r | head -n 1)
if [ -r "$bookmarks" ] ; then
    OUT=$(jsonlz4.py -d "$bookmarks" - | "$FIREFOX/bookmarks.py" | jq .)
    if ! diff -q "bookmarks.json" <(echo "$OUT") ; then
        echo "$OUT" > "bookmarks.json"
#        jsonlz4.py -c "bookmarks.json" "bookmarks.jsonlz4"
        [ -d ".git" ] && git add "bookmarks.json"
        COMMIT=1
    fi
fi

if [ -d ".git" ] && [ "$COMMIT" -gt 0 ] ; then
    git commit --quiet --allow-empty-message --message="update" || true
    git gc --quiet
fi
