#!/bin/sh
set -euf
unset CDPATH

DIR="$(git rev-parse --git-path objects)"
cd "$DIR" || exit 1

# packs
find . -regex "./pack/pack-[0-9a-f]+\\.idx" \
| while read -r pack ; do
    git show-index < "$pack" | cut -f 2 -d ' '
done

# objs
find . -regex "./[0-9a-f][0-9a-f]/[0-9a-f]+" \
| while read -r obj ; do
    echo "$obj" | tr -d "./"
done
