#!/bin/sh
set -euf

# http://www.brendangregg.com/blog/2018-02-09/kpti-kaiser-meltdown-performance.html

exec \
perf stat -e raw_syscalls:sys_enter -a -I 1000
