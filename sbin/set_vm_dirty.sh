#!/bin/sh
set -euf -o pipefail

echo $((512*1024*1024)) | sudo tee /proc/sys/vm/dirty_bytes
echo $((256*1024*1024)) | sudo tee /proc/sys/vm/dirty_background_bytes
