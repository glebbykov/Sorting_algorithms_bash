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

# bubble sort function
bubble_sort() {
  local -a arr=("$@")
  for ((i = 0; i < ${#arr[@]}; i++)); do
    for ((j = 0; j < ${#arr[@]}-1; j++)); do
      if (( ${arr[j]} > ${arr[j+1]} )); then
        temp=${arr[j]}
        arr[j]=${arr[j+1]}
        arr[j+1]=$temp
        # increment the counter
        counter=$((counter + 1))
      fi
    done
  done
  echo "${arr[*]}"
}

bubble_sort "${numbers[@]}"

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
