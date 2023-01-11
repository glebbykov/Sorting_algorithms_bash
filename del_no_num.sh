#!/bin/bash

filename=$1

# remove all non-numeric characters from the file
sed -i 's/[^0-9]*//g' $filename

echo "All non-numeric characters have been removed from $filename"
