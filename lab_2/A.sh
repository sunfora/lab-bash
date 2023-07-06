#!/usr/bin/bash
pd=`mktemp -d`
mkfifo $pd/pipe

ps -U $USER | tail -n +2 | awk '{print $1":"$4}' | tee >(wc -l > $pd/pipe) | cat $pd/pipe - | tee $1

rm -r $pd
