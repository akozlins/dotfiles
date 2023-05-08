#!/bin/bash
set -eu

PKG=$1

mkdir -p -- "$XDG_CACHE_HOME/makepkg"
cd -- "$XDG_CACHE_HOME/makepkg"

#git clone --branch "packages/$PKG" --single-branch https://github.com/archlinux/svntogit-packages.git
yay --getpkgbuild -- "$PKG"
cd -- "$PKG/trunk"

git stash
if [ -r "$XDG_CONFIG_HOME/makepkg/$PKG.patch" ] ; then
    git apply --verbose "$XDG_CONFIG_HOME/makepkg/$PKG.patch"
fi
if [ -d "$XDG_CONFIG_HOME/makepkg/$PKG" ] ; then
    cp -arv -- "$XDG_CONFIG_HOME/makepkg/$PKG/*" .
fi

makepkg -s
