#!/bin/bash
set -euf

user=$1

useradd -m -s /bin/zsh $user
passwd $user
cat > /etc/sudoers.d/$user << EOF
$user ALL=(ALL) ALL
EOF

mkdir -pv -- "$HOME/.ssh"
touch "$HOME/.ssh/authorized_keys"
chmod -R go-rwx "$HOME/.ssh"
