#!/bin/bash
cpuidle=`vmstat | awk '{print $15}' | grep -v id |xargs`
memfree=`free -h | awk '{print $7}' | xargs`
now=`date '+%Y-%m-%d %H:%M'`
xsetroot -name " cpuidle:$cpuidle% memfree:$memfree $now "

exit 0