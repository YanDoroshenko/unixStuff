#!/bin/sh

CHARGE_PROFILE_FILE="$(realpath .)/.config/.charge_profile"

touch $CHARGE_PROFILE_FILE

if [ "$1" = "-init" ]; then
    system76-power charge-thresholds --profile $(cat $CHARGE_PROFILE_FILE)
elif [ "$(cat $CHARGE_PROFILE_FILE)" = "full_charge" ]; then
    doas -n /sbin/system76-power charge-thresholds --profile max_lifespan &&
    echo "max_lifespan" > $CHARGE_PROFILE_FILE &&
    notify-send "Conserving battery lifetime"
else
    doas -n /sbin/system76-power charge-thresholds --profile full_charge &&
    echo "full_charge" > $CHARGE_PROFILE_FILE &&
    notify-send "Battery charging to full"
fi

