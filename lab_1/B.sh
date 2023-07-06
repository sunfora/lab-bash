#!/usr/bin/bash

IFS="\n"

result=""
while read line && [[ $line != "q" ]]; do
    result+=$line
done
echo $result
