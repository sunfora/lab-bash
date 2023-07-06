#!/usr/bin/bash
echo "$@" | tr ' ' $'\n' | sort -n | tail -1
