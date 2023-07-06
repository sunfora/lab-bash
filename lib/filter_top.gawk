#!/usr/bin/gawk -f

BEGIN {
    skip=1
}

{
    if (!skip && !first) {
       print $0
       fflush(stdout)
    }
    skip = skip != (NF == 0)
    first = (NF == 0)
}
