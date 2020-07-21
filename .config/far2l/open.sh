#!/bin/bash
set -euf

mime=$(xdg-mime query filetype "$1")

case "$mime" in
    inode/*)
        ;;
    application/pdf)
        exec evince "$1"
        ;;
    audio/*)
        exec vlc "$1"
        ;;
    image/*)
        exec geeqie "$1"
        ;;
    video/*)
        exec vlc "$1"
        ;;
    text/*)
        [[ "$1" == *.md ]] && command -pv okular &> /dev/null && exec okular "$1"
        exec gedit "$1"
        ;;
    *)
        exec zenity --error --text="unknown mime type: '$mime'"
        ;;
esac
