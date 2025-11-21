#!/usr/bin/env bash
# Quick module for continuously prompting for input 
# Call it like so:
# bash prompt.sh <SCRIPT NAME>
script=$*
read args
printf "\033[1A"
printf "\033[2K\r"
while [ "$args" != "Done" ] 
do

    output=$($script $args)
    # count=$(printf "%s" $output | count_new)
    #count=$(count_new "$output") 
    count=$(printf '%s\n' "$output" | count_new)
    if [ "${#output}" -ge 1 ]; then
        printf "%s\n" "$output"
    fi 
    read args
    for ((i=0; i<=count; i++)); do
        printf "\033[1A"
        printf "\033[2K\r"
    done
done
