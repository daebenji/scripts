#!/bin/bash

usage(){
	echo "Usage: $0 <file.aax>"
	exit 1
}

inputFile=$1
activationBytes=57d4ea09
outputFile=output.m4b
[[ -z $inputFile ]] && usage

ffmpeg -activation_bytes $activationBytes -i $inputFile -c copy $outputFile
