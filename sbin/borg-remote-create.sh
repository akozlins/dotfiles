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
        [ -z "$line" ] && continue
        [[ $line == "#"* ]] && continue
        PATTERNS+=("--pattern='$line'")
    done < "$3"
fi

PREFIX="$HOST"

dir="$(dirname -- "$(readlink -f -- "$0")")"
"$dir/borg-remote.sh" "$HOST" "$REPO" \
    create \
    --verbose \
    --list --filter AME \
    --stats \
    --exclude-caches \
    --exclude-if-present .borgexclude --keep-exclude-tags \
    --one-file-system \
    "${PATTERNS[@]}" \
    "ssh://$HOST/$REPO::$PREFIX-{utcnow:%Y%m%dT%H%M%S}"

# https://borgbackup.readthedocs.io/en/stable/usage/general.html
export BORG_RELOCATED_REPO_ACCESS_IS_OK=yes
export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK=yes

borg prune \
    --verbose \
    --list \
    --stats \
    --keep-daily=6 \
    --keep-weekly=3 \
    --keep-monthly=-1 \
    --glob-archives="$PREFIX-*" \
    "$REPO"

sync
