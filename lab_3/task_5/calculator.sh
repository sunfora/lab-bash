#!/usr/bin/bash
SOURCE_DIR=$(dirname $(realpath ${BASH_SOURCE:-0}))
eval source `find $SOURCE_DIR -name connect.sh`

# redirect stdin
exec 0< commands

num=1
op='+'

print_state () {
    clear
    echo "Mode: $op"
    echo "Value: $num"
}

MODE () {
    op=$1
}

DATA () {
    num=$(BC_LINE_LENGTH=0 bc -l <<< "scale=0; $num $op ($1)")
}

while [[ -n $num ]] 
do
    print_state
    read input 
    eval $input 
done
exit 1
