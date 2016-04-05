#!/bin/sh
set -eu -o pipefail

declare -a files=(.conkyrc .dmrc .gitconfig .gmrunrc .gv .inputrc .nethackrc .rootrc \
                  .xscreensaver)

for file in ${files[@]}
do
  [ -f $file ] && ln -sfv ~{/.dotfiles,}/$file
done
