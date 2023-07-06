#!/usr/bin/bash
if [[ $PWD == $HOME ]]; then
    echo $HOME
    exit 0
else
    echo "Error: script started not from $HOME"
    exit 1
fi
