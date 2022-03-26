HDMI_FULL_HD=$(xrandr | grep mm | grep "HDMI-[0-9].* connected" | grep 1920x1080)
HDMI_QHD=$(xrandr | grep mm | grep "HDMI-[0-9].* connected" | grep 2560x1440)

if [ "$HDMI_FULL_HD" ]; then
    xrandr --output HDMI-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-0 --off --output DP-1 --off --output eDP-1-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1-1 --off --output HDMI-1-1 --off
elif [ "$HDMI_QHD" ]; then
    xrandr --output HDMI-0 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-0 --off --output DP-1 --off --output eDP-1-1 --mode 1920x1080 --pos 2560x0 --rotate normal --output DP-1-1 --off --output HDMI-1-1 --off
fi
