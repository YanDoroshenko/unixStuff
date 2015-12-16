#!/bin/bash
echo "Enter number of pages: ";
read pages; # No idea for getting number of pages for now
pages=$(($pages-1))  # Numeration starts from 0
file=$1
file=$(basename "$file")
file="${file%.*}" # Removing extension
mkdir "converted$file"
dir="converted$file"
for i in {0..$pages..1}; do
    convert -density 500 $file["$i"].pdf  $dir/$file"$i".jpg;
done;
echo "Done!"
