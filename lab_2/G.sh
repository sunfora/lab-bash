#!/usr/bin/bash

remove_spaces () {
    egrep -o '[^[:space:]].*[^[:space:]]' /dev/stdin
}

get_numbers () {
   cat /dev/stdin | sed 's![^[:digit:]]\+! !g' | remove_spaces | tr ' ' $1
}

sort_pid () {
    sort -nt: -k 1 /dev/stdin
}

bytes_read () {
    gawk 'BEGINFILE { if (ERRNO) {nextfile} } #skip bad 
    /read_bytes/ { print FILENAME, $2 }' /proc/[0-9]*/io | get_numbers ':' | sort_pid
}

proc_cmd () {
    ps -eo '%p:%c' | tail -n +2 | remove_spaces | sort_pid
}

start_time () {
    gawk 'BEGINFILE { if (ERRNO) {nextfile} } #skip bad
    { print FILENAME, $22 }' /proc/[0-9]*/stat | get_numbers ':' | sort_pid 
}

dump () {
    sleep ${1-0}
    join -t: <(start_time) <(bytes_read) | join -t: - <(proc_cmd)
}

gawk -F':' '
    BEGIN {
    	OFS = ":"
    }
    {
	f += (FNR == 1)
	if (f == 1) {
	    procs[$1,$2] = $1 
	    bytes[$1] = $3
	    # clear fields and cut command
	    pid = $1
	    $1=$2=$3=""
	    cmd[pid] = substr($0, 4)
	} else {
	    if (procs[$1,$2]) {
	    	bytes[procs[$1,$2]] -= $3
	    }
        }
    }
    END {
       for (pid in bytes) {
           print pid, bytes[pid], cmd[pid] 
       }
    }
' <(dump ${1-60} &) <(dump &)| remove_spaces | sort -nrt: -k 2 | head -5 
