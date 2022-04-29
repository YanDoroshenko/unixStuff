#!/bin/sh
case $1 in
    up) brillo -A 10 ;;
    down) brillo -U 10 ;;
    *) echo "Usage: ./brightness.sh OPERATION\nWhere OPERATION could be up or down"
esac

BRIGHTNESS=$(brillo)

NOTIFICATION_ID_FILE="/tmp/brightness_notification_id"
touch "$NOTIFICATION_ID_FILE"

NOTIFICATION_ID=$(cat $NOTIFICATION_ID_FILE)

if [ -z $NOTIFICATION_ID ]; then
    notify-send -i "display-brightness-symbolic" -h "int:value:$BRIGHTNESS" "Brightness: $BRIGHTNESS %" -u low -t 1000 -p > "$NOTIFICATION_ID_FILE"
else
    notify-send -r "$NOTIFICATION_ID" -i "display-brightness-symbolic" -h "int:value:$BRIGHTNESS" "Brightness: $BRIGHTNESS %" -u low -t 1000 -p > "$NOTIFICATION_ID_FILE"
fi

echo $NOTIFICATION_ID
