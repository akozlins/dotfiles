#!/bin/sh
set -euf

name=$1
url=$2

cat << EOF | sudo tee -a /etc/pacman.conf
[$name]
Server = $url
EOF
