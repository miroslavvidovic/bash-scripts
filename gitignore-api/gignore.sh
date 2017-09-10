#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      gia.sh
#   created:   24.01.2017.-13:11:58
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   curl
# Description:
#   Use the gitignore.io API to generate .gitignore files.
# Usage:
#   .gitignore file for linux, latex and python
#   gia.sh linux,latex,pyhton
#
#   .gitignore file for java
#   gia.sh java
#
#   list all supported languages and platforms
#   gia.sh list
# -----------------------------------------------------------------------------
# Script:

main(){
  languages=$1

  # Check if input is provided
  if [[ -z $languages ]]; then
    echo "Provide a list of languages and tools for the script."
    exit 1
  fi

  # API response
  output=$(curl -L -s "https://www.gitignore.io/api/$languages")
  # Grep errors
  errors=$(echo "$output" | grep  ERROR)
  # Grep data
  data=$(echo "$output" | grep -v ERROR)

  # Send data to standard output
  echo "$data"
  # Send errors to standard error
  >&2 echo "$errors"
}

main "$@"

exit 0
