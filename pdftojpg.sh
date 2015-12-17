#!/bin/bash

echo "Enter number of pages: ";
read pages; # No idea for getting number of pages for now
pages=$(($pages-1))  # Numeration starts from 0
file=$1
file=$(basename "$file")
file="${file%.*}" # Removing extension
if [ ! -d "converted$file" ]; then
    mkdir "converted$file";
fi;
dir="converted$file";
for i in $(eval echo {0..$pages}); do
    convert -density 500 $file.pdf["$i"]  $dir/$file"$i".jpg;
done;
echo "Done!";
