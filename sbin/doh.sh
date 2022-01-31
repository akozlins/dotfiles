#!/bin/sh
set -euf

REMOTE="$1"
NAME="$2"

exec \
curl -s -H 'accept: application/dns+json' "https://$REMOTE?name=$NAME&type=A"
