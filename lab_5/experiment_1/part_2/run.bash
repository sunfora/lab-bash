#!/usr/bin/bash

run () {
    ./mem.bash &
    pid=$!
    ./monitor.bash $pid &
    monitor=$!
}

is_alive () {
    [[ -d /proc/$1 ]]
    result=$?
    
    (( result )) && {
	kill $2
    }

    return $result
}

echo "starting: "
run
task_1=( $pid $monitor )

run 
task_2=( $pid $monitor )

echo ${task_1[@]} 
echo ${task_2[@]} 

while is_alive ${task_1[@]} || is_alive ${task_2[@]}
do
    :
done
