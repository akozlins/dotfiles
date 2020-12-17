#!/bin/sh

# remove comments
sed -i -e '/^#.*/d' vlcrc
# trim empty lines
sed -i -e '/^$/N;/^\n$/D' vlcrc
