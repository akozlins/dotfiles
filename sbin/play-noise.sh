#!/bin/sh
set -euf

VOL=-50db

exec \
play -n synth whitenoise vol "$VOL"
