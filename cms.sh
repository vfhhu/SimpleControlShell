#!/bin/bash

act=$1
prog=$2

start() {
   $prog &
   echo `/bin/ps -fu $USER| grep "$prog" | grep -v "grep" | grep -v "cms" | awk '{print $2}' `
}
stop() {
   process_id=`/bin/ps -fu $USER| grep "$prog" | grep -v "grep" | grep -v "cms" | awk '{print $2}' `
   if [[ -z "$process_id" ]]; then
      echo "$prog is NOT running"
   else
      kill $process_id
   fi 
}
status(){
   process_id=`/bin/ps -fu $USER| grep "$prog" | grep -v "grep" | grep -v "cms" | awk '{print $2}' `
   if [[ -z "$process_id" ]]; then
      echo "$prog is NOT running"
   else
      echo "$prog is running"
      exit 1
   fi
}
restart(){
    stop
    start
}


case "$act" in 
start)
   start
   ;;   
stop)
   stop
   ;;
status)
   status
   ;;
restart)
   restart
   ;;

*)
   echo "Usage: $0 {start|stop|status|restart}"
esac

exit 0 