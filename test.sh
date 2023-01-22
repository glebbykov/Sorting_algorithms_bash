#!/bin/bash

# Function for bubble sort
bubble_sort() {
    local -a nums=("$@")
    local temp
    for ((i = 0; i < ${#nums[@]}-1; i++)); do
        for ((j = 0; j < ${#nums[@]}-i-1; j++)); do
            if [[ ${nums[j]} -gt ${nums[j+1]} ]]; then
                temp=${nums[j]}
                nums[j]=${nums[j+1]}
                nums[j+1]=$temp
            fi
        done
    done
    echo "${nums[@]}"
}

# Function for insertion sort
insertion_sort() {
    local -a nums=("$@")
    local n=${#nums[@]}
    for ((i=1; i<n; i++)); do
        local key=${nums[i]}
        local j=$((i-1))
        while [[ $j -ge 0 && ${nums[j]} -gt $key ]]; do
            nums[j+1]=${nums[j]}
            j=$((j-1))
        done
        nums[j+1]=$key
    done
    echo "${nums[@]}"
}

# Read numbers from user input
read -a numbers

# Prompt the user to select a sorting algorithm
echo "Select a sorting algorithm:"
echo "1. Bubble sort"
echo "2. insertion sort"
read -p "Enter your choice: " choice

# Sort the numbers based on user's choice
case "$choice" in
    1)
      sorted=($(bubble_sort "${numbers[@]}") )
      ;;
    2)
      sorted=($(insertion_sort "${numbers[@]}") )
      ;;
    *)
      echo "Error: Invalid selection"
      exit 1
      ;;
esac

# Print the sorted numbers
echo "Sorted numbers: ${sorted[@]}"