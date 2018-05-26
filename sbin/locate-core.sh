#!/bin/sh
set -euf

exec \
locate -r '/core\.[0-9]\+$'
