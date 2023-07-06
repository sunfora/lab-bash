#!/usr/bin/bash
SOURCE_DIR=$(dirname $(realpath ${BASH_SOURCE:-0}))

interface=$(find $SOURCE_DIR -name interface.sh)
calculator=$(find $SOURCE_DIR -name calculator.sh)

tmux new-session -s task_5 -d "$interface; bash"
tmux split-window -t task_5   "$calculator; bash"
tmux select-layout even-horizontal

tmux attach -t task_5
