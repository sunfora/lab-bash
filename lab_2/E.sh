#!/usr/bin/bash
./D.sh | awk -F ' : |=' '
BEGIN {
    group=-1
    group_total = 0
    group_count = 0
    format = "Average_Running_Children_of_ParentID=%s is %s\n"
}

{
    if (group == -1) {
    	group = $4
    }

    if (group == $4) {
    	++group_count
	group_total += $6
    } else {
        printf format, group, (group_total / group_count)
	group = $4
    	group_total = $6
	group_count = 1	
    }

    print $0
}

END {
    printf format, group, (group_total / group_count)
}
' | tee $1
