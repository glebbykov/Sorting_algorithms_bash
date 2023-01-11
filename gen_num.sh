#!/bin/bash

filename=random_numbers.txt

# generate 10000 random numbers
for i in {1..10000}; do
    echo -n $((RANDOM % 200001 - 100000)) >> $filename
    echo  >> $filename
done

# Checking that the generated numbers are only numerical
grep -vE "^[-]?[0-9]+$" $filename
if [ $? -eq 0 ]; then
   echo "Error: file contains non-numeric elements"
   exit 1
fi

echo "10000 random numbers between -100000 and 100000 have been generated and saved in $filename"

./del_no_num.sh random_numbers.txt
