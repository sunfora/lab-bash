#!/usr/bin/bash

sdir="~/lab_3/task_4"
calc="$sdir/calc.sh"

# start top
tmux new-session -s task_4 -d top

# run calculations
tmux new-window   -t task_4   -n 'calc' "($calc)"
tmux split-window -t task_4:1           "($calc)"
tmux split-window -t task_4:1           "($calc)"
tmux select-layout even-horizontal

# run limiter
tmux new-window   -t task_4   -n 'manip' "read -p 'process: ' num && ($sdir/limit_calc.sh \$num)"
tmux split-window -t task_4:2
tmux select-layout even-horizontal 

# show 
tmux attach -t task_4
