#!/bin/sh

if [ -z "${GIT_AUTHOR_NAME:+x}" ] ; then
    export GIT_AUTHOR_NAME="$USER"
fi

if [ -z "${GIT_AUTHOR_EMAIL:+x}" ] ; then
    export GIT_AUTHOR_EMAIL="${EMAIL:-$USER@$HOST}"
fi

if [ -z "${GIT_COMMITTER_NAME:+x}" ] ; then
    export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
fi

if [ -z "${GIT_COMMITTER_EMAIL:+x}" ] ; then
    export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
fi
