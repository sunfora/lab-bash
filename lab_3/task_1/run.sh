#!/usr/bin/bash

start_time=$(date +%T_%F)
url='www.net_nikogo.ru'

mkdir ~/test && {
    echo "catalog test was created successfully" > ~/report
    touch ~/test/$start_time   
}

ping -c 4 $url || echo "$(date +%T_%F) host is down" >> ~/report 
