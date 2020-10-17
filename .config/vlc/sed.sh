#!/bin/sh

sed -i -e '/^#.*/d' vlcrc
sed -i -e '/^$/N;/^\n$/D' vlcrc
