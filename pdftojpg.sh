#!/bin/bash

file=$1 # First cmd argument
if [ -z $file ]; then
    echo "Usage: bash pdftojpg.sh yourfile.pdf"
    exit 1
fi
if [ ! -f $file ]; then 
    echo "File does not exist"
    exit 1
fi
pages=`pdfinfo -meta $file | grep Pages | cut -d' ' -f11` # Getting pages number from meta (-f 11 is stable, AFAIK)
pages=$(($pages-1)) # Pages count from 0
short=$(basename $file) # Dropping path
short=${short%.*} # Removing extension
dir="converted_$short"
if [ ! -d $dir ]; then
    mkdir $dir
fi
for i in $(eval echo {0..$pages}); do
    convert -density 500 $file[$i]  $dir/"$short"_Page$(($i+1)).jpg # Density for it to look readable
    echo "Page $((i+1)) of $((pages+1)) converted" # Progress
done
echo "Done!"
