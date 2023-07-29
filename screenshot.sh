#!/bin/sh

MAX_DELAY=15
DMENU_FONT="DejaVuSansMono:size=9:antialias=true:autohint=true"
DMENU_NB="#2c1a1a"
DMENU_NF="#efefef"
DMENU_SB="#5cd5ff"
DMENU_SF="#000000"

delay=$(seq 0 $MAX_DELAY | dmenu -p "Screenshot delay:" -nf $DMENU_FONT -nb $DMENU_NB -nf $DMENU_NF -sb $DMENU_SB -sf $DMENU_SF)

ALL_SCREENS="Capture all screens"
ONE_SCREEN="Capture current screen"
SELECT="Select area to capture"

capture=$(echo -e "$ONE_SCREEN\n$SELECT\n$ALL_SCREENS" | dmenu -nf $DMENU_FONT -nb $DMENU_NB -nf $DMENU_NF -sb $DMENU_SB -sf $DMENU_SF)

tmp_file="/tmp/$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo).png"

if [ "$capture" == "$SELECT" ]; then
    sxot --geom $(sx4 -c "#5cd5ff"; sleep $delay) | ffmpeg -i - "$tmp_file"
else
    sleep $delay
    sxot | ffmpeg -i - "$tmp_file"
fi

COPY_TO_CLIPBOARD="Copy screenshot to clipboard"
SAVE_TO_FILE="Save screenshot to file"

output=$(echo -e "$COPY_TO_CLIPBOARD\n$SAVE_TO_FILE" | dmenu -nf $DMENU_FONT -nb $DMENU_NB -nf $DMENU_NF -sb $DMENU_SB -sf $DMENU_SF)

if [ "$output" == "$COPY_TO_CLIPBOARD" ]; then
    cat "$tmp_file" | xclip -selection clipboard -target image/png
    notify-send "Screenshot copied to clipboard" -h "string:image-path:$tmp_file" -t 2000
    rm $tmp_file
else
    output_file="$(zenity --file-selection --save --title="Save screenshot as:").png"
    if [ ! -z $output_file ]; then
        mv $tmp_file $output_file
        notify-send "Screenshot saved as $output_file" -h "string:image-path:$output_file" -t 2000
    fi
fi

