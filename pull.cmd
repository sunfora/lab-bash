@echo off
ncat -l %1 | 7z x -si -a"oa" -t"tar" 
