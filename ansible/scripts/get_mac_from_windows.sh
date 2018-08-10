#!/bin/bash

[ $# -eq 0 ] && { echo "Usage: $0 <host/hostgroup> <win_command> i.e. $0 windowsserver ipconifg /all"; exit 1; }

#ARGS="${*:2}"

ansible $1 -m win_command -a "ipconfig /all" | grep -i physische | awk -F ':' '{print $2}' | sed 's/-/:/g' | tr '[:upper:]' '[:lower:]'

