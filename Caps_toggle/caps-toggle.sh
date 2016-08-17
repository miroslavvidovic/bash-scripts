#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	caps-toggle.sh
# 	17.08.2016.-11:30:20
# -----------------------------------------------------------------------------
# Description:
#   Disable capslock.
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
  usage: $0 [-n] [-y] [-h]

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
  while getopts 'nyh' flag; do
    case "${flag}" in
      n) capslock_off ;;
      y) capslock_on ;;
      h) help ;;
      *) echo -e "\n"; help ;;
    esac
  done
}

check_for_empty_input "$@"
main "$@"

exit 0
