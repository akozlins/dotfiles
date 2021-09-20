#!/bin/bash
set -euf

~/.dotfiles/sbin/BAT-energy.sh 0 >> "BAT0.$(date +%Y).out"
