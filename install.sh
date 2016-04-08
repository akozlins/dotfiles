#!/bin/sh
set -eu -o pipefail

declare -a files=(conkyrc dmrc emacs gitconfig gmrunrc gv inputrc nethackrc rootrc \
                  xinitrc xscreensaver xsession \
                  Xdefaults)

for file in ${files[@]}
do
  [ -f $file ] && ln -sfv ~/.dotfiles/$file ~/.$file
done
