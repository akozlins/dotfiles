#!/bin/sh
set -eu -o pipefail

declare -a files=(bashrc bash_profile bash_logout inputrc \
                  alias.d alias
                  xinitrc xscreensaver xsession dmrc \
                  Xdefaults \
                  conkyrc emacs gitconfig gmrunrc gv nethackrc rootrc)

for file in ${files[@]} ; do
  if [[ -f $file || -d $file ]] ; then
    ln -sfv ~/.dotfiles/$file ~/.$file
  fi
done
