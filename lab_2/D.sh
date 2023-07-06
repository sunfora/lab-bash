#!/usr/bin/bash
ps -e --sort ppid -o pid | tail -n +2 | xargs -L1 ./proc_burst.sh | tee $1
