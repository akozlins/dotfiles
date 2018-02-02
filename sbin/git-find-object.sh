#!/bin/sh

object="$1"

git log --pretty=format:'%T %h' --all \
| while read -r tree commit ; do
    if git ls-tree -r "$tree" | grep -q "$object" ; then
        echo "$commit"
    fi
done
