#!/bin/sh
set -eu -o pipefail

declare -a files=(zshrc
                  Xdefaults xinitrc xscreensaver xsession dmrc
                  rootrc
                  conkyrc yaourtrc iftoprc gv gitconfig
                  gmrunrc nethackrc
                  emacs.d vim nanorc
                  mime.types tkpacman
                  config/fbpanel config/firejail config/openbox config/pulse/client.conf config/systemd
                  config/pavucontrol.ini config/qxkb.cfg config/user-dirs.dirs
                  )

git submodule init
git submodule update

mkdir -p ~/.config
mkdir -p ~/.config/pulse

for file in ${files[@]} ; do
  if [[ -f $file || -d $file ]] ; then
    ln -sfv -T ~/.dotfiles/$file ~/.$file
  fi
done

ln -sfv -T ~/.dotfiles/bin ~/bin

curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
