#!/bin/sh

export TEST_XINITRC="$TEST_XINITRC:$(date --iso-8601=ns)"

. "$HOME/.xsession"
