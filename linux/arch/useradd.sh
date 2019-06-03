#!/bin/bash
set -euf

user=$1

useradd -m -s /bin/zsh $user
passwd $user
cat > /etc/sudoers.d/$user << EOF
$user ALL=(ALL) ALL
EOF

mkdir ~/.ssh
touch ~/.ssh/authorized_keys
chmod -R go-rwx ~/.ssh
