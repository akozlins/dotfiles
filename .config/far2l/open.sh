#!/bin/bash
set -euf

mime=$(xdg-mime query filetype "$1")

case "$mime" in
    text/*|application/json|inode/x-empty)
#        exec gedit "$1"
#        exec xdg-open "$1"
        exec my_open_text "$1"
        ;;
    image/*)
#        exec xdg-open "$1"
        exec my_open_image "$1"
        ;;
    audio/*|video/*)
#        exec xdg-open "$1"
        exec my_open_video "$1"
        ;;
    application/pdf)
#        exec xdg-open "$1"
        exec my_open_pdf "$1"
        ;;
    application/postscript)
        exec okular "$1"
        ;;
    application/octet-stream)
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

exit 1
