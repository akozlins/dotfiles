#!/bin/bash

paste <(cat << EOF
$HOME
/run/media/$USER
/
EOF
) <(cat << EOF | column -t -s '\t' -R 1
$HOME
/run/media/$USER
/
EOF
) <(cat << EOF
 &H:
 &M:
 &Z:
EOF
)
