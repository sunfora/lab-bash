#!/usr/bin/bash

prog1="nano"
prog2="vi"
prog3="links"
prog4="exit"

while true 
do

clear
cat <<< "Menu:
[1] $prog1
[2] $prog2
[3] $prog3
[4] $prog4"

read -p "> " ch

case $ch in
  1) $prog1 ;;
  2) $prog2 ;;
  3) $prog3 ;;
  4) clear && $prog4
esac

done

clear
