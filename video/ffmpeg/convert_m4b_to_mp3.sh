#!/bin/bash
ffmpeg -i output.m4b -acodec libmp3lame -ab 192k output.mp3
