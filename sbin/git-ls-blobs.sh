#!/bin/bash

objects=$(git rev-list --all --objects)

git cat-file --batch-all-objects --batch-check | sort -k3nr \
| while read -r sha1 type size ; do
    object=$(echo "$objects" | grep "$sha1")
    echo "$object $size"
done
