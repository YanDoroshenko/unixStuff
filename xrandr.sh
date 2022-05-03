#!/bin/sh
{
sleep $1

HDMI=$(xrandr | grep "HDMI-[0-9].* connected" | cut -d' ' -f1)

[ -n "$HDMI" ] && xrandr --output $HDMI --auto --left-of eDP-1-1 --output eDP-1-1 --auto || xrandr --auto
} &
