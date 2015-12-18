#!/bin/bash
while [ true ]; do
    count=`netstat -s | grep "total packets" | cut -d' ' -f5` # Count packages
    if [ `netstat -s | grep "total packets" | cut -d' ' -f5` = $count ]; then
	xset -led 3;
    else
	xset led 3;
    fi
done;
