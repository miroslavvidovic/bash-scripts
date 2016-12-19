#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	check_process.sh
# 	19.12.2016.-15:59:03
# -----------------------------------------------------------------------------
# Description:
#   Check if a process is running.
# Usage:
# 
# -----------------------------------------------------------------------------
# Script:

process=$1

# Check if gedit is running
if pgrep "$process" > /dev/null
then
    echo "$process running"
    echo "----------------"
    ps aux | grep $process | grep -v grep | grep -v $0
else
    echo "$process not running"
fi

exit 0
