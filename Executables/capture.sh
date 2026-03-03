#!/usr/bin/bash
FOLDER=$(date +"%m_%d_%Y")
FILENAME=$(date +"%H:%M").jpg
FULLNAME=~/Pictures/annex/$FOLDER/$FILENAME
PATH=$PATH:/home/robot/HR-pi/Executables
if [ ! -d ~/Pictures/annex/$FOLDER ]
    then 
        mkdir ~/Pictures/annex/$FOLDER
fi

fswebcam -r 1280x720 --no-banner $FULLNAME >> ~/capturelog.txt
Rotate180 $FULLNAME >> ~/capturelog.txt
echo $FULLNAME >> ~/capturelog.txt