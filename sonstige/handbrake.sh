#!/bin/bash

usage() {
    cat <<EOM
    Usage:
    $(basename $0) ARGS1:<PATH to Source> ARGS2<PATH to Destination>

EOM
    exit 0
}

[ -z $1 ] && { usage; }

$1 = $SOURCE
$2 = $DESTINATION

cd $SOURCE
for i in $(ls -1 *.MOV); do cpulimit -l 120 HandBrakeCLI -i $SOURCE/$i -o $DESTINATION/$i -Z "Android 480p30"; done
