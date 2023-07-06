#!/usr/bin/bash

top_stream () {
    top -b -d 1 -p $1
}

top_stream $(pgrep mem.bash) | tee monitor.log
