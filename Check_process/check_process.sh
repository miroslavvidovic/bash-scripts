#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      check_process.sh
#   created:   19.12.2016.-15:59:03
#   revision:  12.02.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Requirements:
#
# Description:
#   Check if a process is running.
# Usage:
#   check_process.sh process_name
# -----------------------------------------------------------------------------
# Script:

process="$1"

# Check if a proces is running
if pgrep "$process" > /dev/null
then
    echo "$process running"
    echo "----------------"
    ps aux | grep "$process" | grep -v grep | grep -v "$0"
else
    echo "$process not running"
fi

exit 0
