#!/bin/bash

$1=$VBOXNAME

vboxmanage controlvm "$VBOXNAME" poweroff
vboxmanage unregistervm "$VBOXNAME"  --delete

rm -rf .vagrant
vagrant up
