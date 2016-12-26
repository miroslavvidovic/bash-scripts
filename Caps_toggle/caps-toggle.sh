#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      caps-toggle.sh
#   created:   17.08.2016.-11:30:20
#   revision:  26.12.2016.
#   version:   1.1
# -----------------------------------------------------------------------------
# Requirements:
#   setxkbmap
# Description:
#   Easy way to disable or enable the capslock key.
# Usage:
#   caps-toggle.sh -y  --- enable capslock
#   caps-toggle.sh -n  --- disable capslock
# -----------------------------------------------------------------------------
# Script:

capslock_on(){
  setxkbmap -option
  echo "capslock key is enabled"
}

capslock_off(){
  setxkbmap -option caps:none
  echo "capslock key is disabled"
}

help(){
cat<< EOF
  usage: $(basename "$0") [-n] [-y] [-h]

  Disable / Enable the capslock key.
  ------
  -n
    Disable the capslock key
  -y
    Enable the capslock key
  -h
    Show this help message
EOF
}

check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      echo -e "Invalid command\n"
      help
      exit 0
    fi
}

main(){
  check_for_empty_input "$@"
  while getopts 'nyh' flag; do
    case "${flag}" in
      n) capslock_off ;;
      y) capslock_on ;;
      h) help ;;
      *) echo -e "\n"; help ;;
    esac
  done
shift "$((OPTIND - 1))" 
}

main "$@"

exit 0
