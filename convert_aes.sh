#!/bin/bash
#Create a key file and fill it with hex characters.

if [ -z $1 ]; then
        echo "Specify a video file."
        exit 1
fi

splitFilePrefix=$(echo $1 | awk -F. '{print $1}')


#KeyFile="$splitFilePrefix.key"
#openssl rand 16 > $KeyFile
KeyFile="key_file.key"
encryptionKey=`cat $KeyFile | hexdump -e '16/1 "%02x"'`

#Specify the filename and location of newly encrypted files.
encryptedSplitFilePrefix="enc/${splitFilePrefix}"

#Make an enc directory for the new files.
if [ ! -d enc ]; then
        mkdir enc
fi

#Copy the contents of the keyfile and list file to it to make it portable.
cp $KeyFile enc
cp ${splitFilePrefix}.m3u8 enc

#The following lines make AES decryption possible, without them file playback is impossible.
sed -i '4i#EXT-X-ALLOW-CACHE:YES' enc/${splitFilePrefix}.m3u8
sed -i '5i#EXT-X-KEY:METHOD=AES-128,URI="\'$KeyFile'\"' enc/${splitFilePrefix}.m3u8

#Encrypt the files
numberOfTsFiles=`ls ${splitFilePrefix}*.ts | wc -l`
for (( i=0; i<$numberOfTsFiles; i++ ))
do
        initializationVector=`printf '%032x' $i`
        openssl aes-128-cbc -e -in ${splitFilePrefix}$i.ts -out ${encryptedSplitFilePrefix}$i.ts -nosalt -iv $initializationVector -K $encryptionKey
done