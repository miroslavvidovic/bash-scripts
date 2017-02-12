#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      repeat-command.sh
#   created:   28.01.2017.-19:00:27
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements: 
# 
# Description:
#   Run a command in an infinite loop.
# 
# Usage:
#   repeat-command.sh "command" sleep-time
#   repeat-command.sh "du -sh" 5
# 
# -----------------------------------------------------------------------------
# Script:

check_input(){
  if [[ -z $command ]]; then
    echo "No command"
    exit 1
  fi
}

set_pause_time(){
  if [[ -z $pause_time ]]; then
    pause_time=2
  fi
}

main(){
  command=$1
  pause_time=$2

  check_input
  set_pause_time

  while true 
  do
    $command
    echo "-----------------------"
    sleep "$pause_time"
  done
}

main "$@"

exit 0
