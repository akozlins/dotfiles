#!/bin/sh
set -euf

# user
USER=$1
HOME=/home/$USER
SHELL=/bin/zsh

useradd  --shell "$SHELL" --create-home -- "$USER"
passwd -- "$USER"

cat > "/etc/sudoers.d/10-$USER" << EOF
$USER ALL=(ALL) ALL
EOF

mkdir -pv -- "$HOME/.ssh"
touch "$HOME/.ssh/authorized_keys"
chmod -R go-rwx "$HOME/.ssh"
