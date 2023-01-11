#!/bin/bash

file=$1

# check if file exists
if [ ! -f $file ]; then
  echo "Error: file not found"
  exit 1
fi

# read file into an array
IFS=$'\n' read -d '' -r -a numbers < $file

# check if file contains non-numeric elements
for i in "${numbers[@]}"; do
  if ! [[ $i =~ ^[0-9]+$ ]]; then
    echo "Error: file contains non-numeric elements"
    exit 1
  fi
done

# bubble sort function
bubble_sort() {
  local -n arr=$1

  for ((i = 0; i < ${#arr[@]}; i++)); do
    for ((j = 0; j < ${#arr[@]}-1; j++)); do
      if (( ${arr[j]} > ${arr[j+1]} )); then
        temp=${arr[j]}
        arr[j]=${arr[j+1]}
        arr[j+1]=$temp
      fi
    done
  done
  echo "${arr[*]}"
}

bubble_sort numbers
