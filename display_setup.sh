#!/bin/sh
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Middle Emulation Enabled" 1
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Accel Speed" 0.6
