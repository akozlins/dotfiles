#!/bin/sh
set -euf
export LC_ALL=C

object="$1"

git log --pretty=format:'%cI %T %h' --all \
| while read -r date tree commit ; do
    git diff-tree --no-commit-id -r "$commit" \
    | while read -r _ _ _ h t f ; do
        echo "$date $commit $h $t $f"
    done
    continue
done
