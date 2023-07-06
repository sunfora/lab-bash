#!/usr/bin/bash
sdir=~/lab_3/task_2
$sdir/schedule.sh $1 2> /dev/null && $sdir/listen.sh
