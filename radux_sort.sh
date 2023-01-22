#!/bin/bash

file=$1

# Check if the file exists before attempting to read it
if [ ! -f $file ]; then
  echo "Error: file not found"
  exit 1
fi

# read file into an array
IFS=$'\n' read -d '' -r -a numbers < $file

# Initialize counters
counter=0
counter2=0

# check if file contains non-numeric elements
for i in "${numbers[@]}"; do
  if ! [[ $i =~ ^[0-9]+$ ]]; then
    echo "Error: file contains non-numeric elements"
    exit 1
  else
    counter2=$((counter2 + 1))
  fi
done

# Get the current time in seconds since the epoch
start_time=$(date +%s)

# Radix sort function
radix_sort() {
    local -a nums=("$@")
    local max_len=5
    local radix=1
    
    for ((i=0; i<max_len; i++)); do
        # Create an array for each digit (0-9)
        for digit in {0..9}; do
            declare -a "digit_$digit=()"
            counter=$((counter + 1))
        done
        
        # Sort the numbers into the appropriate digit array
        for num in "${nums[@]}"; do
            local digit=$((num/radix%10))
            eval "digit_$digit+=($num)"
            counter=$((counter + 1))
        done
        
        # Concatenate the digit arrays back into the original array
        nums=()
        for digit in {0..9}; do
            eval "nums+=(\"\${digit_$digit[@]}\")"
            counter=$((counter + 1))
        done
        radix=$((radix*10))
        counter=$((counter + 1))
    done
    
    echo "${nums[@]}"
}

radix_sort "${numbers[@]}"

# Get the current time in seconds since the epoch
end_time=$(date +%s)

# Calculate the duration
duration=$((end_time - start_time))

# Print info
echo "______________________________" >> statistic.txt
echo "Script: $0" >> statistic.txt
echo "Time taken: $duration seconds" >> statistic.txt
echo "Number of elements: $counter2" >> statistic.txt
echo "Cycle number: $counter" >> statistic.txt