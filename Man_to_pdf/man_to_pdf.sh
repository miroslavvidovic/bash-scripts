#!/bin/bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	man_to_pdf.sh
# 	28.02.2016.-15:25:06
# -------------------------------------------------------
# Description:
#   Bash script that converts a man page of a program to
#   pdf format and saves in in the /tmp directory and then
#   opens the file in the evince application.
# Usage:
#   man_to_pdf.sh vim
#
#   Find and convert man pages for vim application and
#   then save them in pdf and open them in evince.
# -------------------------------------------------------
# Script:

# Name of the applicaton from the input
program_name=$1

# Check if a man page exists
check_for_man_page() {
    man "$program_name" > /dev/null 2>&1
}

# Check for emty input
check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      echo "No application given in input."
      exit 0
    fi
}

generate_and_open_pdf(){
  # Create a directory if it does not exist
  mkdir -p /tmp/man_to_pdf

  # Create a pdf version of the manual
  man -t  $program_name | ps2pdf - /tmp/man_to_pdf/$program_name.pdf

  # Open the manual in evince
  evince /tmp/man_to_pdf/$program_name.pdf &
}

check_for_empty_input "$@"

if check_for_man_page
then
  generate_and_open_pdf
else
  echo "No man page for $program_name"
fi

exit 0
