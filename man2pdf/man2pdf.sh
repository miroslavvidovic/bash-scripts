#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      man2pdf.sh
#   created    28.02.2016.-15:25:06
#   revision:  28.07.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Requirements:
#   xgd-open
#   ps2pdf
# Description:
#   Script converts a man page to a pdf file, saves it the /tmp directory
#   and opens it.
# Usage:
#   man2pdf.sh vim
#   will convert vims manual to pdf and open it
# -----------------------------------------------------------------------------
# Script:

# Check for empty input
check_for_empty_input(){
  if [ $# -eq 0 ];
  then
    echo "No application given in input."
    exit 0
  fi
}

# Check if a man page exists
check_for_man_page() {
  local app="$1"
  man "$app" > /dev/null 2>&1
}

generate_and_open_pdf(){
  local app="$1"
  # Create a directory if it does not exist
  mkdir -p /tmp/man_to_pdf
  # Create a pdf version of the manual
  man -t  "$app" | ps2pdf - /tmp/man_to_pdf/"$app".pdf
  # Open the pdf manual
  xdg-open /tmp/man_to_pdf/"$app".pdf &
}

main(){
  check_for_empty_input "$@"
  # Name of an application, tool or something that has a manual from the input
  app_name="$1"

  if check_for_man_page "$app_name"
  then
    generate_and_open_pdf "$app_name"
  else
    echo "No man page for $app_name"
  fi
}

main "$@"

exit 0
