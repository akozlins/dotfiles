#!/bin/sh
set -euf

mime=$(xdg-mime query filetype "$1")

case "$mime" in
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
        exec gedit "$1"
        ;;
    *)
        exec zenity --error --text="unknown mime type: '$mime'"
        ;;
esac
