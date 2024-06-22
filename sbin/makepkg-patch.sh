#!/bin/bash
set -eu

PKG=$1

mkdir -p -- "$XDG_CACHE_HOME/makepkg"
cd -- "$XDG_CACHE_HOME/makepkg"

#git clone --branch "packages/$PKG" --single-branch https://github.com/archlinux/svntogit-packages.git
yay --getpkgbuild -- "$PKG"
cd -- "$PKG"

git stash
if [ -r "$XDG_CONFIG_HOME/makepkg/$PKG.patch" ] ; then
    git apply --verbose "$XDG_CONFIG_HOME/makepkg/$PKG.patch"
fi

makepkg -s --nobuild --cleanbuild
[ -d "$XDG_CONFIG_HOME/makepkg/$PKG" ] && find "$XDG_CONFIG_HOME/makepkg/$PKG" -name '*.patch' | while read -r p ; do
    patch --forward --strip=1 --input="$f"
done
makepkg --noextract -f

makepkg --install
