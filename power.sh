#!/bin/sh

BACKLIGHT_LEVEL=$(xbacklight -get)

if [ "$(system76-power profile | head -1 | cut -d' ' -f3)" = "Battery" ]; then
    system76-power profile balanced
else
    system76-power profile battery
fi

xbacklight -set "$BACKLIGHT_LEVEL"

notify-send "Power profile: $(system76-power profile | head -1 | cut -d' ' -f3)"


