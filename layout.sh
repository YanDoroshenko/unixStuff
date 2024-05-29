#!/bin/sh
{
sleep $1

eDP=$(xrandr | grep "eDP-[0-9].* connected" | cut -d' ' -f1)
HDMI=$(xrandr | grep "HDMI-[0-9].* connected" | cut -d' ' -f1)
DP=$(xrandr | grep "^DP-[0-9].* connected" | cut -d' ' -f1)

[ "$1" -eq 0 ] && xrandr $(xrandr --listactivemonitors | awk '{print " --output "; print $4; print " --off"}' ORS='')

[ -n "$HDMI" -a -n "$DP" ] && xrandr --output "$eDP" --auto --output "$DP" --primary --auto --right-of "$eDP" --output "$HDMI" --auto --right-of "$DP"
[ -n "$HDMI" -a -z "$DP" ] && xrandr --output "$eDP" --auto --output "$HDMI" --auto --right-of "$eDP" --primary
[ -n "$DP" -a -z "$HDMI" ] && xrandr --output "$eDP" --auto --right-of "$eDP"
[ -z "$DP" -a -z "$HDMI" ] && xrandr --output "$eDP" --auto

feh --bg-scale "/usr/share/slock/background_full.jpeg"
} &

