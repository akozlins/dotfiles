#!/bin/bash

objects=$(git rev-list --all --objects)

git cat-file --batch-all-objects --batch-check | grep blob | sort -k3nr \
| while read -r sha1 type size ; do
    name=$(echo "$objects" | grep "$sha1" | awk '{print $2}')
    echo "$sha1 $size $name"
done
