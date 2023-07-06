#!/usr/bin/bash

def ()
{
    local name=$1
    
    local argparse=''
    local argc=0
    
    for ((i=2; i < $#; i++)); do
	case ${!i} in 
	   "[") continue ;;
	   "]") break ;;
	esac
        argc=$((argc + 1))
	argparse+="local ${!i}=\$$((i - 2));"
    done
    if [[ "$argparse" != "" ]]; then
        argparse+="shift $argc;"
    fi
    body=$(cat | egrep -v "^[[:space:]]*#" | grep . | paste -s -d'|' - -)
    eval "$name () { $argparse cat \$@ | $body;}"

}
