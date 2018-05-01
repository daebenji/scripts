#!/bin/bash
set -x

echo $1
echo $2

if [ -z "$1" ]
then 
    echo "no filename provided"
    echo "usage: sudo mount.sh <filename> <path>"
else
    if [ -z "$2" ]
    then
        echo "Error: no Path provided"
        echo "usage: sudo mount.sh <filename> <path>"
    else
        cd $2
        losetup /dev/loop2 $1
        tcplay --map=truecrypt2 --device=/dev/loop2
        test ! -d /mnt/foo && sudo mkdir /mnt/foo
        sudo mount /dev/mapper/truecrypt2 /mnt/foo
    fi
fi
