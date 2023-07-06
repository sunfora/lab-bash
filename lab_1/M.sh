#!/usr/bin/bash

cat ${1:-/dev/stdin}| awk -f tobars.awk | column -t -s' ' 

