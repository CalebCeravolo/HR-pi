#!/usr/bin/env bash

script=$*
last_output=""
count=0
read args
printf "\033[1A"
printf "\033[2K\r"

while [ "$args" != "Done" ]; do
    output="$($script "$args")"

    if [ "$output" != "$last_output" ]; then
        for ((i=0; i<count; i++)); do
            printf "\033[1A"
        done
        printf "\033[2K\r"
        printf "%s\n" "$output"
        last_output="$output"
    fi
    count=$(printf '%s\n' "$output" | count_new)

    while read -r -t 0; do 
        read args
        printf "\033[1A"
        printf "\033[2K\r"
    done
    # read args
   
    
    # printf "\033[1A"
    # printf "\033[2K\r"
    
done
