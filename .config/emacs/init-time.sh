#!/bin/sh
set -euf

emacs -q --eval='(message "%s" (emacs-init-time))'
