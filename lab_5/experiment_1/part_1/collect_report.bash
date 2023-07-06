#!/usr/bin/bash

echo "journal logs:"
dmesg | grep "mem.bash" | tail -2
echo
echo "size of array:"
tail -1 report.log

