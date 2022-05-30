#!/bin/sh

# remove comments
#sed -i -e '/^#.*/d' vlcrc
# trim empty lines
#sed -i -e '/^$/N;/^\n$/D' vlcrc

temp=$(mktemp)

awk '
    /^\[/ {
        section = $0;
    }
    /^[^[#]/ {
        if (section != "") {
            print "";
            print section;
            section = "";
        }
        print;
    }
' vlcrc > "$temp"

mv -- "$temp" vlcrc
