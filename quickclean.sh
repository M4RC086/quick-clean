#!/bin/bash

if [[ $1 == help ]] || [[ $1 == -h ]]  || [[ $1 == --help ]]; then
    echo "Usage: quickclean [folder]" 
fi

folder=$1
if [[ -z $1 ]]; then
    folder=.
fi


TEXT=(doc docx eml msg odt pages rtf tex txt wpd)
AUDIO=(mp3 mid ogg wav wma aif m3u m4a flac)
VIDEO=(3gp asf avi flv m4v mov mp4 mpg swf ts vob wmv)
IMAGE=(bmp dcm dds djvu gif heic jpg jpeg png psd tga tif)
FILE_TYPES=(AUDIO VIDEO IMAGE)


# Create the folders to orgaize the files
for c_folder in ${FILE_TYPES[@]}; do
    mkdir $folder/${c_folder}
done



for file in $folder/*; do
    for type in ${FILE_TYPES[@]}; do
        declare -n c_type=$type 
    
        for ext in ${c_type[@]}; do
            if [[ $file == *$ext ]]; then
                mv $file $folder/$type
                break
            fi
        done
    done
done