#!/bin/bash
set -e

if [[ $1 == help ]] || [[ $1 == -h ]]  || [[ $1 == --help ]]; then
    echo "Usage: quickclean [folder]" 
fi

FOLDER=$1
if [[ -z $1 ]]; then
    FOLDER=$(pwd)
fi

NUM_FILES=$(ls "$FOLDER/"| wc -l)


# Extensions per type of file
TEXT=(doc docx eml msg odt pages rtf tex txt wpd)
AUDIO=(mp3 mid aac ogg wav wma aif m3u m4a flac opus)
VIDEOS=(3gp asf avi flv m4v mov mp4 mpg swf ts vob wmv mkv webm)
IMAGES=(bmp dcm dds svg gif jpg jpeg png psd tga tif jpp jxl pxd tiff webp)
EXECUTABLES=(apk app bat bin cmd com exe ipa jar run sh ex)
CODE=(appx wasm toml env xml hcl clj json graphql class cpp cs html css js h java kt lua m md pl py jsx sb3 sln swift vb vcxproj xcodeproj yml rb php h hpp r sql php rs)
COMPRESSED=(7z cbr deb gz pkg rar rpm tar.gz xapk zip zipx tar)
DOCUMENTS=(pdf csv xlsx pptx)
THREE_D=(3dm blend dae fbx max obj tf vrm ma stp part vsj mesh gh crz bbmodel)
FONTS=(vfb pfa ass rst otf ttf fnt)

FILE_TYPES=(TEXT THREE_D FONTS AUDIO VIDEOS IMAGES EXECUTABLES CODE DOCUMENTS COMPRESSED)
USED_FILE_TYPES=()



# Check what folders will be used
for file in "$FOLDER"/*; do
    file_extension="${file#*.}"

    for type in ${FILE_TYPES[@]}; do
    
        declare -n c_type=$type
 
        if [[ " ${c_type[*]} " == *" $file_extension "* ]]; then # Check if the file extension is on the array of this type 
            if [[ ! " ${USED_FILE_TYPES[*]} " == *" $type "* ]]; then # Check duplicated types
                USED_FILE_TYPES+=($type)
                break
            fi
        fi
    done
    
done

# Create the folders to organise the files
for c_folder in ${USED_FILE_TYPES[@]}; do
    mkdir "$FOLDER/${c_folder}" -p
done


# Move files into folders
for file in "$FOLDER"/*; do
    [[ -f $file ]] || continue
    file_extension="${file#*.}"
    for type in ${USED_FILE_TYPES[@]}; do
    
        declare -n c_type=$type 
        
        if [[ " ${c_type[*]} " == *" $file_extension "* ]]; then
            mv "$file" "$FOLDER/$type/"
            break
        fi
        
    done
done



# Move to "UNKNOWN" files with unknown extensions
for thing in "$FOLDER"/*; do
    if [[ -f $thing ]]; then
        mkdir "$FOLDER/UNKNOWN" -p
        mv "$thing" "$FOLDER"/UNKNOWN/
    fi
done
 
echo -- DONE! $NUM_FILES files cleaned --
ls "$FOLDER"