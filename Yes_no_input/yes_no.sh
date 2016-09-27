#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	yes_no.sh
# 	02.09.2016.-08:44:19
# -----------------------------------------------------------------------------
# Description:
#   Example of yes/no user input.
# Usage:
#   Can be used inside other bash scripts.
# -----------------------------------------------------------------------------
# Script:

# Let the user make a choice about something and return a standard answer.
# usage : choice <prompt>
# e.g. choice "Do you want to see the log?"
# @returns: global variable CHOICE
choice(){
  CHOICE=''
  local prompt="$*"
  local answer

  read -p "$prompt" answer
  case "$answer" in
    [yY1] ) CHOICE='y';;
    [nN0] ) CHOICE='n';;
    *     ) CHOICE="$answer";;
  esac
}

main(){
  choice "Do you want to look at the error log file? [y/n]: "
  if [ "$CHOICE" == "y" ]; then
    less /var/log/apache2/error.log
  fi
}

main "$@"

exit 0

