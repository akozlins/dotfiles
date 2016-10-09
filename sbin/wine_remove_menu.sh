#!/bin/sh
set -eu -o pipefail

rm -vf ~/.local/share/mime/packages/x-wine*
rm -vf ~/.local/share/applications/wine-extension*
rm -vf ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*
rm -vf ~/.local/share/mime/application/x-wine-extension*

rm -vf ~/.config/menus/applications-merged/wine*
rm -vfr ~/.local/share/applications/wine
rm -vf ~/.local/share/desktop-directories/wine*
rm -vf ~/.local/share/icons/????_*.{xpm,png}
rm -vf ~/.local/share/icons/*-x-wine-*.{xpm,png}
