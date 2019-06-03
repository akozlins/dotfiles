#!/bin/sh

if [ -z ${GIT_AUTHOR_NAME:+x} ] ; then
    >&2 echo "WARN: GIT_AUTHOR_NAME is not defined"
    export GIT_AUTHOR_NAME="$USER"
fi

if [ -z ${GIT_AUTHOR_EMAIL:+x} ] ; then
    export GIT_AUTHOR_EMAIL="$EMAIL"
fi

if [ -z ${GIT_COMMITTER_NAME:+x} ] ; then
    export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
fi

if [ -z ${GIT_COMMITTER_EMAIL:+x} ] ; then
    export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
fi
