#!/bin/bash

file=$1 # First cmd argument
if [ -z $file ]; then
    echo "Usage: bash pdftojpg.sh yourfile.pdf">&2
    exit 1
fi
if [ ! -f $file ]; then 
    echo "File does not exist">&2
    exit 1
fi
echo "Enter density (100-2000), higher density -> better quality, slower convertation. Default - 300"
read density
if ! [[ $density =~ ^[0-9]+$ ]]; then
    density=300
else
    if [ $density -lt 100 ]; then
	echo "Density is too low, text will be unreadable">&2
	exit 1
    fi
    if [ $density -gt 2000]; then
	echo "Density is too high, converting will take forever">&2
	exit 1
    fi
fi
pages=`pdfinfo -meta $file | grep Pages | cut -d' ' -f11` # Getting pages number from meta (-f 11 is stable, AFAIK)
pages=$(($pages-1)) # Pages count from 0
short=$(basename $file) # Dropping path
short=${short%.*} # Removing extension
dir="converted_$short"
if [ ! -d $dir ]; then
    mkdir $dir
fi
echo "Starting convertation with density $density" 
for i in $(eval echo {0..$pages}); do
    convert -density $density $file[$i]  $dir/"$short"_Page$(($i+1)).jpg # Density for it to look readable
    echo "Page $((i+1)) of $((pages+1)) converted" # Progress
done
echo "Done!"
