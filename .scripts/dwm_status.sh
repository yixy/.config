#!/bin/bash
get_battery_charging_status() {
	if $(acpi -b | grep --quiet Discharging)
	then
		echo -n "Discharging";
	else # acpi can give Unknown or Charging if charging, https://unix.stackexchange.com/questions/203741/lenovo-t440s-battery-status-unknown-but-charging
		echo -n "Charging";
	fi
}

#cpuidle=`vmstat | awk '{print $15}' | grep -v id |xargs`
cpuidle=`top -b -n 1 |awk 'BEGIN{FS=","} NR==3{print $4}' |awk '{print $1}'`
memfree=`free -h | awk '{print $7}' | xargs`
is_charge=`echo "$(get_battery_charging_status)"`
charge_percent=`acpi -b | awk 'BEGIN{FS=","} {print $2}'|xargs`
volume=`amixer get Master | awk /%/'{match($0,/[0-9]+/,a);match($6,/(on|off)/,b);printf("volume:%s%[%s]",a[0],b[0])}'`
now=`date '+%Y-%m-%d %H:%M'`
xsetroot -name " cpuidle:$cpuidle% memfree:$memfree ${is_charge}:${charge_percent} $volume $now "
exit 0
