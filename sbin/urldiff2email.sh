#!/bin/bash
set -euf

URL="$1"
DELAY="${2:-1h}"
EMAIL="${3:-}"

NEW="$(mktemp)"
OLD="$(mktemp)"
DIFF="$(mktemp)"

cleanup() {
    rv=$?
    rm -- "$NEW" "$OLD" "$DIFF"
    exit $rv
}
trap cleanup EXIT

while [ true ] ; do
    if [ -x /bin/lynx ] ; then
        /bin/lynx --dump "$URL" > "$NEW"
    elif [ -x /bin/html2text ] ; then
        curl "$URL" | /bin/html2text --decode-errors=ignore > "$NEW"
    fi

    if [ -s "$OLD" ] ; then
        diff -u "$OLD" "$NEW" > "$DIFF" || true
        if [ -s "$DIFF" ]; then
            cat "$DIFF"
            if [ -n "$EMAIL" ] ; then
                cat "$DIFF" | mail -s "DIFF: $URL" "$EMAIL"
            fi
        fi
    fi
    cp -- "$NEW" "$OLD"

    sleep "$DELAY"
done
