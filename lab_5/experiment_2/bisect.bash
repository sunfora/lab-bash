#!/usr/bin/bash

L=1000000
R=3000000

mid () {
    M=$(( (L + R) / 2 ))
    ./run.bash $M 30 | ./check.bash
    return $?
}

while (( R - L > 1 )) 
do
    echo "Iteration: [$L $R)"

    if mid
    then
	L=$M	
    else
	R=$M
    fi
done
