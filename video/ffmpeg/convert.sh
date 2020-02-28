#!/bin/bash
set -x

videoOptions="-vf scale=1920:-1 -preset slow -tune film -profile:v high -pix_fmt yuv420p -level 4.1 -crf 19"
audioOptions='-b:a 640k'
vCodec=libx264
aCodec=ac3
case "$1" in
	"-s")
		outputFile=$(echo $inputFile | sed "s/.mp4/-sample.mp4/")
		sample="-ss 360 -t 50"
		inputFile=$2
		[[ -z $inputFile ]] && echo "Keine Datei zum konvertieren angegeben"
		[[ -z $inputFile ]] && echo "Error: usage ./convert.sh <movie> ec:1" && exit 1
		[[ ! -f $inputFile ]] && echo "Error: $inputFile not found ec:2" && exit 2
		;;
	*)
		inputFile=$1
		[[ -z $inputFile ]] && echo "Keine Datei zum konvertieren angegeben"
		[[ -z $inputFile ]] && echo "Error: usage ./convert.sh <movie> ec:1" && exit 1
		[[ ! -f $inputFile ]] && echo "Error: $inputFile not found ec:2" && exit 2
		;;
esac
[[ -z $sample ]] && outputFile=$(echo $inputFile | sed "s/.mp4/-converted.mp4/")
ffmpeg -i $inputFile $sample -map 0:0 -vcodec $vCodec $videoOptions -map 0:1 -acodec $aCodec $audioOptions -scodec copy $outputFile
