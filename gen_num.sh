#!/bin/bash

filename=random_numbers.txt

echo "Enter the number of random numbers to generate: "
read count

# generate $count random numbers
for i in $(seq 1 $count); do
    echo -n $((RANDOM % 200001 - 100000)) >> $filename
    echo  >> $filename
done

# Checking that the generated numbers are only numerical
grep -vE "^[-]?[0-9]+$" $filename
if [ $? -eq 0 ]; then
   echo "Error: file contains non-numeric elements"
   exit 1
fi

echo "$count random numbers between -100000 and 100000 have been generated and saved in $filename"

./del_no_num.sh random_numbers.txt
