#!/bin/sh
set -euf

REMOTE="$1"
NAME="$2"

exec \
curl -v -s -H 'accept: application/dns+json' "$REMOTE?name=$NAME&type=A"
