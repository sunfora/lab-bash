sync:with () (
    exec 2>/dev/null
    # kill all foreground processes on exit
    trap "trap - EXIT && pkill -P $BASHPID" EXIT
    # exit if signal recieved
    trap "exit 0" USR1

    echo $BASHPID
    sleep infinity &
    wait

    # if sleep was interrupted 
    # or abnormal signal recieved
    exit 1
)

with:sync () (
    read pid
    kill -USR1 $pid
)

with:mutex () (
    file="$1"
    out=$2

    exec {fd}>"$file"
    flock $fd || exit 1

    with:sync < $out
    cat $out
)
