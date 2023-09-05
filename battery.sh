#!/bin/sh

if [ -z "$(doas -n /sbin/system76-power charge-thresholds | grep "full_charge")" ]; then
    doas -n /sbin/system76-power charge-thresholds --profile full_charge
    notify-send "Battery charging to full"
else
    doas -n /sbin/system76-power charge-thresholds --profile max_lifespan
    notify-send "Conserving battery lifetime"
fi

