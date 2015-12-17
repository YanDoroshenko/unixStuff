#!/bin/bash

file=$1 # First cmd argument
pages=`pdfinfo -meta $1 | grep Pages | cut -d' ' -f11` #Getting pages number from meta (-f 11 is stable, AFAIK)
file=$(basename "$file") # Dropping path
file="${file%.*}" # Removing extension
dir="converted$file";
if [ ! -d "$dir" ]; then
    mkdir "$dir";
fi;
for i in $(eval echo {0..$pages}); do
    convert -density 500 $file.pdf["$i"]  $dir/$file"$i".jpg; # Density for it to look readable
done;
echo "Done!";
