ps -eo pid | xargs -I {} bash -c $'
  cat /proc/{}/status 2> /dev/null | grep -i vmrss | awk \'{print $2, {}}\'
' | sort -n | tail -1 | awk '{print $2}'
