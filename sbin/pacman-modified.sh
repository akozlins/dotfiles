#!/bin/sh
set -euf

pacman -Qii | awk '/^MODIFIED/ { print $2 }'
