#!/usr/bin/bash
SOURCE_DIR=$(dirname $(realpath ${BASH_SOURCE:-0}))
eval source `find $SOURCE_DIR -name connect.sh`

MODE() { :; } 
DATA() { :; }

shopt -s extglob

decode () {
    echo "$1" > /dev/stderr
    case "$1" in
	[+*-^%/])
	    echo "MODE '$1'"
	    ;; 
        (?([-])+([0-9])) 
	    echo "DATA '$1'"
	    ;;
        'QUIT')
	    echo 'QUIT'
            ;;
	*)
	    echo 'FAIL'
            ;;
    esac
}


# redirect output
exec 1> commands

while [[ -p commands ]]
do
    clear > /dev/stderr
    read -p '> ' input
    cmd=$(decode "$input")
    echo $cmd
    eval $cmd
done
