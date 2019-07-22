#!/bin/bash
set -eu

rm -fv ~/.local/share/mime/packages/x-wine*
rm -fv ~/.local/share/applications/wine-extension*
rm -fv ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*
rm -fv ~/.local/share/mime/application/x-wine-extension*

rm -fv ~/.config/menus/applications-merged/wine*
rm -rfv ~/.local/share/applications/wine
rm -fv ~/.local/share/desktop-directories/wine*
rm -fv ~/.local/share/icons/????_*.{xpm,png}
rm -fv ~/.local/share/icons/*-x-wine-*.{xpm,png}
