#!/bin/sh
set -euf

# <https://github.com/nelenkov/android-backup-extractor>

# usage: android-abe.sh unpack adb.ab adb.tar

exec \
java -jar abe-all.jar "$@"
