#!/usr/bin/bash
sbin=`realpath /sbin`

ps -eo pid | xargs -I {} bash -c '
  link=`realpath -q /proc/{}/exe` 
  [[ $link ]] && echo {} $link
' | awk -v sbin=$sbin '$2 ~ sbin {print $1}' | tee $1
