#!/usr/bin/bash
a=1
mod=$((2 ** 32 - 1))
while true
do
   a=$(( (a * 17) % mod ))
   echo $a 
done
