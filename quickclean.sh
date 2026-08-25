#!/bin/bash

if [[ $1 == help ]] || [[ $1 == -h ]]  || [[ $1 == --help ]]; then
    echo "Usage: quickclean [folder]" 
fi

FOLDER=$1
if [[ -z $1 ]]; then
    FOLDER=$(pwd)
fi


# Extensions per type of file
TEXT=(doc docx eml msg odt pages rtf tex txt wpd)
AUDIO=(mp3 mid ogg wav wma aif m3u m4a flac opus)
VIDEOS=(3gp asf avi flv m4v mov mp4 mpg swf ts vob wmv mkv)
IMAGES=(bmp dcm dds djvu gif heic jpg jpeg png psd tga tif jpp sktz jxl pxd tiff)
EXECUTABLES=(apk app bat bin cmd com exe ipa jar run sh ex)
CODE=(appx c class cpp cs html css js h java kt lua m md pl py jsx sb3 sln swift unity vb vcxproj xcodeproj yml rb php h hpp r sql php rs)
COMPRESSED=(7z cbr deb gz pkg rar rpm tar.gz xapk zip zipx tar)
PDFS=(pdf)

FILE_TYPES=(TEXT AUDIO VIDEOS IMAGES EXECUTABLES CODE COMPRESSED PDFS)
USED_FILE_TYPES=()



# Check what folders will be used
for type in ${FILE_TYPES[@]}; do

    for file in $FOLDER/*; do    
        declare -n c_type=$type 
        for ext in ${c_type[@]}; do
            if [[ ${file,,} == *$ext ]]; then

                USED_FILE_TYPES+=($type)
                break
            fi
        done
    done
    
done

# Create the folders to organise the files
for c_folder in ${USED_FILE_TYPES[@]}; do
        mkdir $FOLDER/${c_folder} -p
done


# Move files into folders
for type in ${USED_FILE_TYPES[@]}; do
    for file in $FOLDER/*; do
        declare -n c_type=$type 
    
        for ext in ${c_type[@]}; do
            if [[ ${file,,} == *$ext ]]; then
                mv "$file" "$FOLDER/$type/"
                break
            fi
        done
    done
done



# Move to "UNKNOWN" files with unknown extensions
for thing in $FOLDER/*; do
    if [[ -f $thing ]]; then
        mkdir $FOLDER/UNKNOWN -p
        mv "$thing" $FOLDER/UNKNOWN/
    fi
done