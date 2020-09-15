#!/bin/bash
set -euf
export LC_ALL=C

diff_tree_opts=(
    # suppress line with commit ID
    --no-commit-id
    # recurse into sub-trees
    -r
    # select files that are Added (A), Copied (C), Deleted (D), Modified (M), Renamed (R)
#    --diff-filter=A
)

# git-log output: 'committer_date tree_hash commit_hash'
git log --pretty=format:'%cI %T %h' --all \
| while read -r date _ commit ; do
    # git-diff-tree output: ':src_mode dst_mode src_sha dst_sha status src_path [dst_path]'
    git diff-tree "${diff_tree_opts[@]}" "$commit" \
    | while read -r _ _ _ h t f ; do
        echo "$date $commit $h $t $f"
    done
    continue
done
