#!/bin/sh
{
sleep $1

HDMI=$(xrandr | grep "HDMI-[0-9].* connected" | cut -d' ' -f1)

[ -n "$HDMI" ] && xrandr --output eDP-1 --auto --output $HDMI --auto --right-of eDP-1 --primary
} &
