#!/bin/bash
set -eu

source -- ./.env
[ -d "$BORG_REPO" ] || exit 0

if true ; then
    TIME_LAST=$(date +%s -d "$(borg list --format='{time}' --last=1)")
    TIME_NOW=$(date +%s)
    TIME_DELTA=$(( (TIME_NOW - TIME_LAST) / 3600 ))
    if [ "$TIME_DELTA" -lt 23 ] ; then
        exit 0
    fi
fi

PATTERNS="./user.patterns"
PREFIX="$USER@{hostname}"
LOG="./.cache/borg.log"
#if command -v jq &> /dev/null ; then
#    LOG="$(borg info --json | jq --raw-output '.cache.path')/borg.log"
#fi

export BORG_RELOCATED_REPO_ACCESS_IS_OK=no
export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK=no

borg create \
    --verbose \
    --list --filter AME \
    --stats \
    --exclude-caches \
    --exclude-if-present .borgexclude --keep-exclude-tags \
    --pattern "R /home/$USER" \
    --patterns-from "$PATTERNS" \
    --one-file-system \
    ::"$PREFIX-{utcnow:%Y%m%dT%H%M%S}" \
    2>&1 | tee -a "$LOG"

borg prune \
    --verbose \
    --list \
    --stats \
    --keep-daily=6 \
    --keep-weekly=3 \
    --keep-monthly=-1 \
    --glob-archives="$PREFIX*" \
    2>&1 | tee -a "$LOG"

sync
