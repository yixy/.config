#!/bin/bash
#cpuidle=`vmstat | awk '{print $15}' | grep -v id |xargs`
cpuidle=`top -b -n 1 |awk 'BEGIN{FS=","} NR==3{print $4}' |awk '{print $1}'`
memfree=`free -h | awk '{print $7}' | xargs`
now=`date '+%Y-%m-%d %H:%M'`
xsetroot -name " cpuidle:$cpuidle% memfree:$memfree $now "

exit 0
