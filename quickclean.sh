#!/bin/bash

if [[ $1 == help ]] || [[ $1 == -h ]]  || [[ $1 == --help ]]; then
    echo "Usage: quickclean [folder]" 
fi

folder=$1
if [[ -z $1 ]]; then
    folder=.
fi





for file in $folder/*; do
    echo $file
    
done