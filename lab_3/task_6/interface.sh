#!/usr/bin/bash

# take pid 
mkfifo handler_info 2> /dev/null
read handler_pid < handler_info
echo $handler_pid 

while [[ -d /proc/$handler_pid ]] 
do
    clear 
    read -p '> ' input
    case "$input" in
	[+]) kill -USR1 $handler_pid 
	     ;;
	[*]) kill -USR2 $handler_pid 
	     ;;
	'TERM') 
	     kill -SIGTERM $handler_pid
	     exit 0
             ;;
    esac
done
