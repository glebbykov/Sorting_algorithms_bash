#!/bin/bash

# Bubble sort function
bubble_sort() {
    local -a arr=("$@")
    # Сonsecutive comparison of adjacent array elements
    for ((i = 0; i < ${#arr[@]}; i++)); do
        for ((j = 0; j < ${#arr[@]}-1; j++)); do
            if [[ ${arr[j]} -gt ${arr[j+1]} ]]; then
                # Swap items
                temp=${arr[j]}
                arr[j]=${arr[j+1]}
                arr[j+1]=$temp
            fi
        done
    done
    echo "${arr[*]}"
}

bubble_sort "$@"
