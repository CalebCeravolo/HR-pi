#!/usr/bin/env bash
# Quick module for continuously prompting for input 
# Call it like so:
# bash prompt.sh <SCRIPT NAME>
script=$*
read args
while [ "$args" != "Done" ] 
do
    $script $args
    read args
done
