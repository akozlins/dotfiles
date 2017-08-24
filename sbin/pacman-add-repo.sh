#!/bin/sh
set -euf

name=$1
url=$2

echo -e "\n[$name]\nServer = $url" | sudo tee -a /etc/pacman.conf
