#!/bin/bash

[ $# -eq 0 ] && { echo "Usage: $0 <host/hostgroup>"; exit 1; }

ARGS="${*:2}"

COMMAND="query user /server:$SERVER"

ansible $1 -m win_command -a "$COMMAND"  | grep -b2 console | grep -v -e UNREACHABLE -e non-zero
