#!/bin/bash

if [ -z $1 ]; then
        echo "Specify an input filename."
        exit 1
fi
vidFile=$(echo "$1" | awk -F. '{print $1}')
echo $vidFile

#Manually specifying binary as it's a newer version of ffmpeg built from source.
#This will create a list file and split the file into pieces every 10 seconds.
/usr/local/bin/ffmpeg -i "$1" -codec copy -hls_time 320 "$vidFile.m3u8"