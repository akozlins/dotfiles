#!/bin/bash
set -euf

mime=$(xdg-mime query filetype "$1")

case "$mime" in
    text/*|application/json|inode/x-empty)
#        [[ "$1" == *.md ]] && command -pv okular &> /dev/null && exec okular "$1"
#        exec gedit "$1"
        exec xdg-open "$1"
        ;;
    image/*)
#        exec geeqie "$1"
        exec xdg-open "$1"
        ;;
    audio/*|video/*)
        exec mpv "$1"
        ;;
    application/pdf)
#        exec evince "$1"
        exec xdg-open "$1"
        ;;
    application/postscript)
        exec okular "$1"
        ;;
    application/octet-stream)
#        exec zenity --info --title="$0" --text="MIME type: '$mime'"
        exec dunstify "MIME type: '$mime'"
        ;;
    application/*)
        exec xdg-open "$1"
        ;;
    inode/*)
        ;;
    *)
        exec zenity --error --title="$0" --text="unknown MIME type: '$mime'"
        ;;
esac
