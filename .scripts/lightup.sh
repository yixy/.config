#!/bin/bash

light=`cat /sys/class/backlight/acpi_video0/brightness `
value=`echo $light+10 | bc | xargs`
~/.scripts/lightset/lightset $value

