#!/bin/bash
inputFile=$1
[[ -z $inputFile ]] && echo "Keine Datei zum konvertieren angegeben"
[[ -z $inputFile ]] && echo "Error: usage ./convert.sh <movie> ec:1" && exit 1

[[ ! -f $inputFile ]] && echo "Error: $inputFile not found ec:2" && exit 2
outputFile=$(echo $inputFile | sed 's/.mkv/-AC3-convert.mkv/g;s/.mp4/-AC3-convert.mp4/g')

aCodec="libmp3lame"
vCodec="libx264"
sample="-ss 0 -t 120"
videoOption="-preset slow -tune film -profile:v high10 -level 4.1 -crf 19"
audioTrack=$(mediainfo --Output=JSON $inputFile | \
	sed -n "/StreamOrder/,/Language/p"  | \
	grep -E 'StreamOrder|Lang|"Format"' | \
	sed "s/,//g;s/ //g;s/\"//g;1,2d" | \
	sed '/Stream/N;y/\n/\t/;/Format/N;y/\n/\t/' | \
	dmenu -l 5 | \
	cut -d\: -f2 | \
	sed 's/Format//')
audioTrack=2
echo "Using AudioTrack: $audioTrack"

ffmpeg -i $inputFile $sample -map 0 -vcodec $vCodec $videoOption -map 0:$audioTrack -scodec copy -acodec $aCodec -b:a 640k $outputFile
