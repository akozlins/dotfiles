#!/bin/sh
set -euf

pacman-key --init
pacman-key --populate archlinux
pacman -Syu
