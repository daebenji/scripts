#!/bin/bash

#fetch script directory
DIR=~/Videos/
inputFile=$(ls -1 $DIR | dmenu -l 10)
outputFile=$(echo $inputFile | sed 's/.mkv/AC3.mkv/g')
ffmpeg -i $DIR/$inputFile -map 0 -vcodec copy -scodec copy -acodec ac3 -b:a 640k $DIR/$outputFile
