#!/bin/bash
set -euf

packages=($(pacman -Qeq))

for p in ${packages[@]} ; do
    pactree -r "$p"
done
