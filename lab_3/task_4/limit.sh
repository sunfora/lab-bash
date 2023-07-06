#!/usr/bin/bash
source "$HOME/lib/concatenative.sh"

def top_stream [ pid update_rate ] << '|'
    top -b -d $update_rate -p $pid 
    ~/lib/filter_top.gawk 
|

def extract_cpu_usage << '|'
    gawk '{if (NF != 0) {print $9; fflush(stdout)}}' 
|

def cpu_stream [ pid update_rate ] << '|'
    top_stream $pid $update_rate
    extract_cpu_usage
|

fcomp () {
    return $(( 1 - `fcalc "$1"` ))
}

fcalc () {
    awk "BEGIN {print ($1); exit 0}"
}

pid_exists () {
    ps -p $1 > /dev/null 
}

resume_before_death () {
    kill -SIGCONT $pid &
    trap - INT TERM EXIT
    kill 0
}

trap resume_before_death INT TERM EXIT 

pid=$1
cpu_usage_limit=${2:-'10'}
update_rate=${3:-'1'}

exec {cpu_stream}< <(cpu_stream $pid $update_rate)

work_pace=1
fair_portion=`ps -p $pid -o %cpu=`

while read -u ${cpu_stream} cpu_usage ; do
    pid_exists $pid || exit
    
    fair_portion=`fcalc "$cpu_usage / $work_pace"`
    fcomp "$fair_portion > 100" &&
        fair_portion=100

    fcomp "$fair_portion > 0" && 
        work_pace=`fcalc "$cpu_usage_limit / $fair_portion"`
    fcomp "$work_pace > 1" &&
        work_pace=1

    printf '%f\t%f\t%f\n' $work_pace $cpu_usage $fair_portion
    
    kill -SIGCONT $pid
    sleep $(fcalc "$update_rate * $work_pace")
    kill -SIGSTOP $pid
done
