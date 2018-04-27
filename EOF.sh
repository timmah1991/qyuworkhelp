#!/bin/bash

#Takes a directory path and, lists the subdirectories and performs a command for each directory in the path. 

while getopts p:c:d: option
do
    case "${option}"
    in
    p) DIRPATH=${OPTARG};;
    c) COMMANDTORUN=${OPTARG};;
    d) DEBUG=${OPTARG};;
    esac
done

for fp in `cd $DIRPATH & ls -d -1 $PWD/**`; do
    echo "Executing $COMMANDTORUN With Parameter $fp"
done