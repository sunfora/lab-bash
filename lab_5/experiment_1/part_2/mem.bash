#!/usr/bin/bash

exec 1> report_$$.log

a=()

for (( i=0; ; i++ ))
do
    ! (( i % 10000 )) && {
	echo $(( i * 10 ))
    }
    a+=(1 1 1 1 1 1 1 1 1 1)
done
