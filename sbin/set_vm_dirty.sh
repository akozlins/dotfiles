#!/bin/sh
set -euf

echo $((512*1024*1024)) | tee /proc/sys/vm/dirty_bytes
echo $((256*1024*1024)) | tee /proc/sys/vm/dirty_background_bytes
