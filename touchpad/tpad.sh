#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      tpad.sh
#   created:   19.05.2016.-13:50:23
#   revision:  05.11.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Requirements:
#
# Description:
#   Activate or deactivate the touchpad on a laptop.
# Usage:
#   tpad.sh [a|d|s|h]
#   Described in the help function below.
# -----------------------------------------------------------------------------
# Script:

# 12 is the id number of the device
# the number can be checked with the xinput commmand
ID=12

deactivate(){
  xinput set-prop $ID "Device Enabled" 0
}

activate(){
  xinput set-prop $ID "Device Enabled" 1
}

# Check the status of the touchpad
check_status(){
  # returns 1 or 0 value to the status variable
  status=$(xinput --list-props $ID | grep "Device Enabled" | cut -f3)
  if [ "$status" -eq 1 ]; then
    echo "Touchpad active"
  else
    echo "Touchpad not active"
  fi
}

help(){
  cat<< EOF
  Enable or disable the touchpad quickly.
  Usage:
  ------
  $0
  -a
    Activate the touchpad
  -d
    Deactivate the touchpad
  -s
    Check the touchpad status
  -h
    Show this help
EOF

}

# Check if the user did not specify any flags when calling the script
# example: bash tpad.sh was called
check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      help
      exit 0
    fi
}

main(){
  while getopts 'adhs' flag; do
    case "${flag}" in
      a) activate ;;
      d) deactivate ;;
      s) check_status ;;
      h) help ;;
    esac
  done

}

# Examples of passing all the input params to functions
check_for_empty_input "$@"
main "$@"

exit 0
