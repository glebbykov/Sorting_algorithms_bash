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

# Selection sort function
selection_sort() {
    local -a arr=("$@")
    for ((i = 0; i < ${#arr[@]}-1; i++)); do
        local min_index=$i
        for ((j = i+1; j < ${#arr[@]}; j++)); do
            if (( ${arr[j]} < ${arr[min_index]} )); then
                min_index=$j
                counter=$((counter + 1))
            fi
        done
        if (( min_index != i )); then
            # Swap items
            temp=${arr[i]}
            arr[i]=${arr[min_index]}
            arr[min_index]=$temp
            counter=$((counter + 1))
        fi
    done
}

selection_sort "${numbers[@]}"

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
