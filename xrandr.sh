#!/bin/sh
{
sleep $1

HDMI=$(xrandr | grep "HDMI-[0-9].* connected" | cut -d' ' -f1)
DP_TYPE_C=$(xrandr | grep "^DP-[0-9].* connected" | cut -d' ' -f1)

[ -n "$HDMI" -a -n "$DP_TYPE_C" ] && xrandr --output eDP-1 --auto --output HDMI-1-0 --primary --auto --right-of eDP-1 --output DP-1 --auto --right-of HDMI-1-0
[ -n "$HDMI" -a -z "$DP_TYPE_C" ] && xrandr --output eDP-1 --auto --output "$HDMI" --auto --right-of eDP-1 --primary
[ -n "$DP_TYPE_C" -a -z "$HDMI" ] && xrandr --output "$DP_TYPE_C" --auto --right-of "$HDMI"
[ -z "$DP_TYPE_C" -a -z "$HDMI" ] && xrandr --output eDP-1 --auto
} &

