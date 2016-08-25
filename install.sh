#!/bin/sh
set -eu -o pipefail

declare -a files=(zshrc \
                  alias
                  xinitrc xscreensaver xsession dmrc \
                  Xdefaults \
                  root rootrc \
                  conkyrc yaourtrc gv gitconfig \
                  gmrunrc nethackrc
                  emacs.d)

for file in ${files[@]} ; do
  if [[ -f $file || -d $file ]] ; then
    ln -sfv -T ~/.dotfiles/$file ~/.$file
  fi
done
