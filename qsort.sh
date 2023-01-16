quicksort() {
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
            else
                right+=("${arr[i]}")
            fi
        done
        left=($(quicksort "${left[@]}"))
        right=($(quicksort "${right[@]}"))
        echo "${left[@]}" "$pivot" "${right[@]}"
    fi
}

quicksort "$@"