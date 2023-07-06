#!/usr/bin/bash

top_stream () {
    top -b -d 1 -p $1
}

top_stream $1 > monitor_$1.log 
