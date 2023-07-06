#!/usr/bin/bash

commands_0=( )
commands_1=( )

turn=0

eval_commands () {
    cur=commands_$turn
    turn=$(( 1 - turn ))
    for cmd in $(eval echo \${$cur[@]})
    do
	eval $cmd
    done
    eval "$cur=( )"
    turn=$(( 1 - turn ))
}
 
add () {
     num=$((num + 2))
}

mul () {
     num=$((num * 2))
}

term () {
    echo "Terminated by other process"
    exit 1
}

num=1

print_state () {
    clear
    echo "Value: $num" 
    echo "-----------"
}

trap 'eval "commands_$turn+=(add)" && echo +' USR1 
trap 'eval "commands_$turn+=(mul)" && echo "*"' USR2

trap term SIGTERM

# lay pid
mkfifo handler_info 2> /dev/null
echo $$ > handler_info && rm handler_info

print_state
while true
do
    wait $sleeping && {
	eval_commands
	(print_state)
        sleep 1 &
	sleeping=$!
    }
done
