#!/bin/bash


folder=$1
if [[ -z $1 ]]; then
    folder=.
fi





for file in $folder/*; do
    echo $file
    
done