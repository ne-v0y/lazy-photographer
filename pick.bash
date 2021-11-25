#!/usr/bin/env bash

count=0
prefix=""
val=""
format=""
file=""
method="cp"
src="./"
dst=""
trap printout SIGINT
function printout() {
    echo "Total phtoto selected: $count"
    exit
}

echo "------------------------------------------"
echo "|  Follow the prompt to pick your photo  |"
echo "|  Press ENTER to use default            |"
echo "|  Press CTRL + C to exit at any point   |"  
echo "------------------------------------------"

echo "Example action: cp $/{/prefix}/ "
echo "Enter file common prefix: "
read prefix
echo "Enter file format(e.g. JPG, C3R): "
read format
if [ "$format" != "" ]
then
    format=".${format}"
fi
echo "Choose operation: cp/mv? Default to cp"
read method
echo "Enter source directory: Default to ./"
read src
if [ "${src: -1}" != "/" ]
then
    src="${src}/"
fi
echo "Enter destination directory: "
read dst
while [ true ]
do
    if [ "$dst" != "" ]
    then
        break
    else
        echo "Please enter a valid destination directory"
        read dst
    fi
done

while [ true ]
do
    echo "Enter file value: "
    read val
    file="${src}${prefix}${val}${format}"
    echo $file
    if test -f "$file"
    then
        cp "$file" "$dst"
        count=$((count+1))
    else
        echo "File doesn't exist, skipped"
    fi
done

echo $prefix $format
