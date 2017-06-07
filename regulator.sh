#!/bin/bash
STATE=$(cat /sys/devices/platform/smapi/ac_connected)
BAT0=$(cat /sys/devices/platform/smapi/BAT0/remaining_percent)
BAT1=$(cat /sys/devices/platform/smapi/BAT1/remaining_percent)
BAT0F=$(cat /sys/devices/platform/smapi/BAT0/force_discharge)
if [ $STATE  == 0 ]; then
    if [ $BAT0 -gt 15 ]; then
        echo 1 > /sys/devices/platform/smapi/BAT0/force_discharge
    else
        echo 0 > /sys/devices/platform/smapi/BAT0/force_discharge
        if [ $BAT1 -le 15 ]; then
            echo "warning low batteries; find the nearest power outlet and charge me or fucking poweroff"
        fi
    fi
else
    if [ $BAT0F == 1 ]; then
        echo 0 > /sys/devices/platform/smapi/BAT0/force_discharge
    fi
fi