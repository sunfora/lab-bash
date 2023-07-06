#!/usr/bin/bash

#ignore errors 
exec 2> /dev/null 

pattern="ProcessID=%s : Parent_ProcessID=%s : Average_Running_Time=%s\n"
sep="[[:space:]]*:[[:space:]]*"

pid=$1
ppid=`cat /proc/$pid/status | grep ppid -i | awk -F $sep '{print $2}'`
art=`cat /proc/$pid/sched | awk -F $sep -f sched.awk`

[[ $pid ]] && [[ $ppid ]] && [[ $art ]] && 
	printf "$pattern" $pid $ppid $art
