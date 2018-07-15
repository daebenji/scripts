#!/bin/bash
set -x
usage() {
    cat <<EOM
    Usage:
    $(basename $0) ARGS1:<PATH to Source> ARGS2<PATH to Destination>

EOM
    exit 0
}

[ -z $1 ] && { usage; }

$SOURCE = $1
$DESTINATION = $2

cd $1
for i in $(ls -1 *.MOV); do cpulimit -l 120 HandBrakeCLI -i $i -o $2/$i -Z "Android 480p30"; done
