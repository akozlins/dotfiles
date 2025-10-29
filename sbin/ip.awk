#!/usr/bin/awk -f

BEGIN {
    skip = 0
}

/^[0-9]+:/ {
    skip = 0
    if(match($2, /^veth.+@/)) {
        skip = 1
    }
}

!skip {
    print
}
