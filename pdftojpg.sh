#!/bin/bash

file=$1 # First cmd argument
if [ -z $file ]; then
    echo "Usage: bash pdftojpg.sh yourfile.pdf";
else
    pages=`pdfinfo -meta $1 | grep Pages | cut -d' ' -f11` #Getting pages number from meta (-f 11 is stable, AFAIK)
    pages=$(($pages-1)) # Pages count from 0
    file=$(basename "$file") # Dropping path
    file="${file%.*}" # Removing extension
    dir="converted$file";
    if [ ! -d "$dir" ]; then
	mkdir "$dir";
    fi;
    for i in $(eval echo {0..$pages}); do
	convert -density 500 $file.pdf["$i"]  $dir/"$file"_Page"$(($i+1))".jpg; # Density for it to look readable
	echo "Page $((i+1)) of $((pages+1)) converted" # Progress
    done;
    echo "Done!";
fi;
