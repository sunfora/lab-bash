#!/usr/bin/bash

path='/var/log/anaconda/X.log'

before='.*] '
match='(%s)'
after='.*'

sed_cmd="s=\($before\)\($match\)\($after\)="'\\2 \\1%s:\\3=p'

warning=`printf "$sed_cmd" "WW" "Warning"`
info=`printf "$sed_cmd" "II" "Information"`

cat $path | sed -n "$warning; $info" | sort -r | cut -d ' ' -f 2- | tee full.log 
