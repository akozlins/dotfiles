#!/bin/bash
set -eu

if [ $# -lt 2 ] ; then
    echo "Usage:"
    echo "  $0 <host> <repo> [<pattern_file>]"
    exit 1
fi

HOST=$1
REPO=$2

PATTERNS=()
if [ $# -ge 3 ] ; then
    while IFS='' read -r line || [ -n "$line" ] ; do
        [ -n "$line" ] && PATTERNS+=("--pattern='$line'")
    done < "$3"
fi

PREFIX="$HOST"

dir="$(dirname -- "$(readlink -e -- "$0")")"
"$dir/borg-remote.sh" "$HOST" "$REPO" \
    create \
    --verbose \
    --list --filter AME \
    --stats \
    --exclude-caches \
    --exclude-if-present .borgexclude --keep-exclude-tags \
    "${PATTERNS[@]}" \
    "ssh://$HOST/$REPO::$PREFIX-{utcnow:%Y%m%dT%H%M%S}"

borg prune \
    --verbose \
    --list \
    --stats \
    --keep-daily=6 \
    --keep-weekly=3 \
    --keep-monthly=-1 \
    --prefix="$PREFIX-" \
    "$REPO"

sync
