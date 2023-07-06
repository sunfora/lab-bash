mem_bash () {
    dmesg | grep "mem.bash" 
}

oom_killed () {
    mem_bash | grep "Killed process $1 (" > /dev/null
    return $?

}

pid_exists () {
    [[ -e /proc/$1 ]]
    return $?
}

all () {
   local array=${@: -1}
   set -- "${@:1:$(($#-1))}"
   for elem in $(eval "echo \${$array[@]}")
   do
	   eval "$@ $elem" || {
	    return 1
	}
   done
}

any () {
   ! all ! $@
   return $?
}

pids=()
while read pid && [[ -n $pid ]]
do
    pids+=($pid)
done
echo "${pids[@]}"

any oom_killed pids
result=$?

while any pid_exists pids 
do
    any oom_killed pids && {
        pkill mem.bash 
        result=1 
    }
done

exit $result
