#!/bin/sh
set -euf

exec \
locate --existing --regexp '/core\.[0-9]\+$'
