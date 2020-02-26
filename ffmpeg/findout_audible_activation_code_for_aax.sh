#!/bin/bash


# https://github.com/inAudible-NG/audible-activator

BIN=/home/daebenji/git/audible-activator/audible-activator.py
userName="ev.fools@gmail.com"
password="f00barf00bar123"

[[ -z $BIN ]] && usage
python3 $BIN --username $userName --password $password -f
