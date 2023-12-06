#!/bin/sh
set -euf

git-ls-blobs.sh \
sort -nk3 --reverse | sort -k4 --stable --uniq | sort -nk3 \
| while read -r commit type size path ; do
    [ "$type" = "blob" ] || continue
    if git check-ignore "$path" > /dev/null ; then
        echo "${commit:0:8} $size i $path"
        continue
    fi
    if [ -z "$(git ls-files "$path")" ] ; then
        echo "${commit:0:8} $size d $path"
        continue
    fi
    echo "${commit:0:8} $size _ $path"
done
