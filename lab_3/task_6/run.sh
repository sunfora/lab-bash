#!/usr/bin/bash
sdir="~/lab_3/task_6"

tmux new-session -s task_6 -d "$sdir/interface.sh; bash"
tmux split-window -t task_6   "$sdir/calculator.sh; bash"
tmux select-layout even-horizontal

tmux attach -t task_6
