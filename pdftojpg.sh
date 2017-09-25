#!/bin/bash

if [ -z "$@" ]; then
    echo "Usage: bash pdftojpg.sh yourfile.pdf">&2
    exit 1
fi
echo "Enter density (100-2000), higher density -> better quality, slower convertation. Default - 300"
read density
    if ! [[ "$density" =~ ^[0-9]+$ ]]; then
	density=300
    else
	if [ "$density" -lt 100 ]; then
	    echo "Density is too low, text will be unreadable">&2
	    exit 1
	fi
	if [ "$density" -gt 2000 ]; then
	    echo "Density is too high, converting will take forever">&2
	    exit 1
	fi
    fi
for file in "$@"; do
    if [ ! -f "$file" ]; then 
	echo "File $file does not exist">&2
	exit 1
    fi
    short=$(basename "$file") # Dropping path
    short=${short%.*} # Removing extension
    if [ ! -f "$short.pdf" ]; then
	echo "$short.pdf does not seem to be a valid PDF file, ignoring"
	continue
    fi
    pages=`pdfinfo "$file" | grep Pages | cut -d' ' -f11` # Getting pages number from meta (-f 11 is stable, AFAIK)
    pages=$(($pages-1)) # Pages count from 0
    dir="converted_$short"
    if [ ! -d "$dir" ]; then
	mkdir "$dir"
    fi
    echo "Starting conversion of $file with density $density" 
    if [ $pages = 0 ]; then
	convert -flatten -density $density "$file[$pages]"  "$dir"/"$short"_Page$(($pages+1)).jpg # Density for it to look readable
    else 
	for i in $(eval echo {0..$pages}); do
	    convert -flatten -density $density "$file[$i]"  "$dir"/"$short"_Page$(($i+1)).jpg # Density for it to look readable
	    echo "Page $((i+1)) of $((pages+1)) converted" # Progress
	done
    fi
    echo "Done converting $file"
done
echo "Done!"
