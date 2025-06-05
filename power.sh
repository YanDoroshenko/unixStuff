#!/bin/sh

POWER_PROFILE_FILE="/home/yan/.config/.power_profile"
BACKLIGHT_LEVEL=$(brillo)

echo $BACKLIGHT_LEVEL

touch $POWER_PROFILE_FILE

if [ "$1" = "-init" ]; then
    system76-power profile $(cat $POWER_PROFILE_FILE)
elif [ "$(cat $POWER_PROFILE_FILE)" = "balanced" ]; then
    system76-power profile battery &&
    echo "battery" > $POWER_PROFILE_FILE &&
    brillo -S "$BACKLIGHT_LEVEL" &&
    notify-send "Power profile: Battery"
else
    system76-power profile balanced &&
    echo "balanced" > $POWER_PROFILE_FILE &&
    brillo -S "$BACKLIGHT_LEVEL" &&
    notify-send "Power profile: Balanced"
fi

