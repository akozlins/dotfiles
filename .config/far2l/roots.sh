#!/bin/bash
set -euf

# TODO: max length

paste <(cat << EOF
$2
$HOME
/run/media/$USER
/
EOF
) <(cat << EOF | column -t -s $'\t' -R 1
$2
$HOME
/run/media/$USER
/
EOF
) <(cat << EOF
 &-
 &H:
 &M:
 &Z:
EOF
)
