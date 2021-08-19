#!/bin/sh
set -euf

SERVER="$1"
NAME="$2"

exec \
curl -s -H 'accept: application/dns+json' "https://$SERVER/dns?name=$NAME&type=A"
