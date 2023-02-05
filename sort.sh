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

# 1.Bubble sort function
bubble_sort() {
  local -a arr=("$@")
  for ((i = 0; i < ${#arr[@]}; i++)); do
    for ((j = 0; j < ${#arr[@]}-1; j++)); do
      if (( ${arr[j]} > ${arr[j+1]} )); then
        temp=${arr[j]}
        arr[j]=${arr[j+1]}
        arr[j+1]=$temp
        counter=$((counter + 1))
      fi
    done
  done
  echo "${arr[*]}"
}

# 2.Insertion sort function
insertion_sort() {
    local -a arr=("$@")
    for ((i = 1; i < ${#arr[@]}; i++)); do
        current_value=${arr[i]}
        j=$i
        while (( j > 0 && ${arr[j-1]} > current_value )); do
            arr[j]=${arr[j-1]}
            j=$((j-1))
            ((counter++))
        done
        arr[j]=$current_value
    done
    echo "${arr[*]}"
}

# 3.Quick sort function
quick_sort() {
    local -a arr=("$@")
    if (( ${#arr[@]} <= 1 )); then
        echo "${arr[*]}"
    else
        local pivot=${arr[0]}
        local -a left=()
        local -a right=()
        for ((i = 1; i < ${#arr[@]}; i++)); do
            if (( ${arr[i]} <= pivot )); then
                left+=("${arr[i]}")
                counter=$((counter + 1))
            else
                right+=("${arr[i]}")
                counter=$((counter + 1))
            fi
        done
        left=($(quick_sort "${left[@]}"))
        right=($(quick_sort "${right[@]}"))
        echo "${left[@]}" "$pivot" "${right[@]}"
    fi
}

# 4.Selection sort function
selection_sort() {
    local -a arr=("$@")
    local n=${#arr[@]}
    for ((i=0; i<n-1; i++)); do
        local min_idx=$i
        for ((j=i+1; j<n; j++)); do
            if [[ ${arr[j]} -lt ${arr[min_idx]} ]]; then
                min_idx=$j
            fi
        done
        if [[ $min_idx != $i ]]; then
            local temp=${arr[i]}
            arr[i]=${arr[min_idx]}
            arr[min_idx]=$temp
            counter=$((counter + 1))
        fi
    done
    echo "${arr[@]}"
}

# 5.Radix sort function
radix_sort() {
    local -a arr=("$@")
    local max_len=5
    local radix=1
    
    for ((i=0; i<max_len; i++)); do
        # Create an array for each digit (0-9)
        for digit in {0..9}; do
            declare -a "digit_$digit=()"
            counter=$((counter + 1))
        done
        
        # Sort the numbers into the appropriate digit array
        for arr in "${arr[@]}"; do
            local digit=$((arr/radix%10))
            eval "digit_$digit+=($arr)"
            counter=$((counter + 1))
        done
        
        # Concatenate the digit arrays back into the original array
        arr=()
        for digit in {0..9}; do
            eval "arr+=(\"\${digit_$digit[@]}\")"
            counter=$((counter + 1))
        done
        radix=$((radix*10))
        counter=$((counter + 1))
    done
    
    echo "${arr[@]}"
}

# Get the current time in seconds since the epoch
start_time=$(date +%s)

echo "Select what type of sorting you want to use:"
echo "1. Bubble sort"
echo "2. Insertion sort"
echo "3. Quick sort"
echo "4. Selection sort"
echo "5. Radux sort"
echo "6. Exit"

read -p "Enter your selections: " -a selection

# Get the current time in seconds since the epoch
start_time=$(date +%s)

case "$selection" in
    1)
      bubble_sort "${numbers[@]}" > sorted_array.txt
      choice='bubble'
      ;;
    2)
      insertion_sort "${numbers[@]}" > sorted_array.txt
      choice='insertion'
      ;;
    3)
      quick_sort "${numbers[@]}" > sorted_array.txt
      choice='quick'
      ;;
    4)
      selection_sort "${numbers[@]}" > sorted_array.txt
      choice='selection'
      ;;
    5) 
      radix_sort "${numbers[@]}" > sorted_array.txt
      choice='radix'
      ;;
    6)
      exit 0
      ;;
    *)
      echo "Error: Invalid selection"
      exit 1
      ;;
esac

# Get the current time in seconds since the epoch
end_time=$(date +%s)

# Calculate the duration
duration=$((end_time - start_time))

# Print info
echo "______________________________" >> statistic.txt
date >> statistic.txt
echo "Type sorting: $choice" >> statistic.txt
echo "Time taken: $duration seconds" >> statistic.txt
echo "Number of elements: $counter2" >> statistic.txt
echo "Cycle number: $counter" >> statistic.txt
