#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      toggle-keyboard.sh
#   created:   24.01.2017.-15:48:32
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements: 
#   xinput
# Description:
#   Disable\enable the built in laptop keyboard.
# Usage:
#   toggle-keyboard.sh enable 
#   toggle-keyboard.sh disable
# -----------------------------------------------------------------------------
# Script:

help(){
cat << EOF

usage: $(basename "$0") [enable | disable]

EOF
}

disable_keyboard(){
  xinput float "$keyboard_id"
}

enable_keyboard(){
  xinput reattach "$keyboard_id" "$slave_pointer"
}

main(){
  # Get the keyboard id
  keyboard_id=$(xinput list | grep "AT Translated" |  awk -F"=" '{print $2}' | awk '{print $1}')
  # Slave pointer to attach the keyboard on enable
  # Hard coded because it is not visible when the keyboard is disabled
  slave_pointer=3

  var="$1"
  if [[ $var = "disable" ]]; then
    disable_keyboard
  elif [[ $var = "enable" ]]; then
    enable_keyboard
  else
    echo "Unknown command"
    help
  fi
}

main "$@"

exit 0
