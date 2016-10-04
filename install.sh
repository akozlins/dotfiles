#!/bin/sh
set -eu -o pipefail

declare -a files=(zshrc \
                  alias
                  Xdefaults xinitrc xscreensaver xsession dmrc \
                  rootrc \
                  conkyrc yaourtrc iftoprc gv gitconfig \
                  gmrunrc nethackrc \
                  emacs.d \
                  mime.types)

for file in ${files[@]} ; do
  if [[ -f $file || -d $file ]] ; then
    ln -sfv -T ~/.dotfiles/$file ~/.$file
  fi
done

ln -sfv -T ~/.dotfiles/bin ~/bin
