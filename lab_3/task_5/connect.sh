QUIT () {
    echo "==="  > /dev/stderr
    echo "DONE" > /dev/stderr
    exit 0
}

FAIL () {
    echo "==="          > /dev/stderr
    echo "INVALID DATA" > /dev/stderr
    exit 1
}

# check if pipe exists
mkfifo ~/lab_3/task_5/commands 2> /dev/null
