#!/bin/sh
set -euf

# user
MY_USER=$1
MY_SHELL=/bin/zsh

useradd  --shell "$MY_SHELL" --create-home -- "$MY_USER"
passwd -- "$USER"

cat > "/etc/sudoers.d/10-$USER" << EOF
$USER ALL=(ALL) ALL
EOF
