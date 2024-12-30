#!/bin/bash
set -eu

PKG=$1

mkdir -p -- "$XDG_CACHE_HOME/makepkg"
cd -- "$XDG_CACHE_HOME/makepkg"

[ -d "$PKG" ] || git clone "https://gitlab.archlinux.org/archlinux/packaging/packages/$PKG.git"
#yay --getpkgbuild -- "$PKG"
cd -- "$PKG"

git stash
git pull
if [ -r "$XDG_CONFIG_HOME/makepkg/$PKG.patch" ] ; then
    git apply --verbose "$XDG_CONFIG_HOME/makepkg/$PKG.patch"
fi

makepkg -s --nobuild --cleanbuild
find "$XDG_CONFIG_HOME/makepkg/$PKG" -name '*.patch' 2>/dev/null \
| while read -r p ; do
    # TODO: use scripts instead of patches
    patch --forward --strip=1 --input="$p"
done
makepkg --noextract -f

makepkg --install
#yay -U ...
