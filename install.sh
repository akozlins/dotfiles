#!/bin/sh
set -eu -o pipefail

cd $(dirname `readlink -f $0`)

declare -a files=(zshrc
                  Xresources xinitrc xscreensaver xsession dmrc
                  rootrc
                  conkyrc yaourtrc iftoprc gv gitconfig
                  gmrunrc nethackrc
                  emacs.d vim nanorc
                  mime.types tkpacman
                  config/fbpanel config/firejail config/openbox config/systemd
                  config/pulse/client.conf
                  config/htop
                  config/pavucontrol.ini config/qxkb.cfg config/user-dirs.dirs
                  config/far2l
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

#ln -s ~/.local/share/applications/mimeapps.list ~/.config/mimeapps.list
