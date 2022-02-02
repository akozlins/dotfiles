#!/bin/bash
set -euf

tool=meld

pkg=$(pacman -Qo "$1" | awk '// { printf "%s-%s", $(NF-1), $NF }')
file=$(echo "$1" | sed 's|^/||')

for m in $(uname -m) any ; do
    pkgfile="/var/cache/pacman/pkg/${pkg}-$m.pkg.tar.zst"
    [ -e "$pkgfile" ] || continue
    exec "$tool" <(tar --extract --to-stdout --file="$pkgfile" "$file") "$1"
done

>&2 echo "E [$0] package '$pkg' not found"
