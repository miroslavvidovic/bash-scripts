#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      vimmv.sh
#   created:   21.08.2017.-10:12:28
#   revision:
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   vim
# Description:
#   Rename multiple files in vim.
# Usage:
#   vimv.sh
#   vimv.sh [file1 file2]
#   vimv.sh $(find . -name "*.py")
# -----------------------------------------------------------------------------
# Script:

TEMP=/tmp/vimv.$$
MOVE_CMD='mv'
IFS=$'\r\n'
GLOBIGNORE='*'
EDITOR=vim

# Check for the same number of lines in src and dest to avoid deletion errors
safety_control() {
  local original_num new_num
  original_num="${#src[@]}"
  new_num="${#dest[@]}"
  if [[ "$original_num" -ne "$new_num" ]]; then
    echo "Please don't delete files in this script. Bad stuff can happen."
    rm "$TEMP"
    exit 1
  fi
}

main() {
  # If no input is provided take everything from LS as src
  if [ $# -ne 0 ]; then
      src=("$@")
  else
      src=($(ls))
  fi

  # Create the temp file
  touch "$TEMP"

  # Write everything from src to temp file line by line
  for (( i = 0; i < ${#src[@]}; i++)); do
      echo "${src[i]}" >> "$TEMP"
  done

  "$EDITOR" "$TEMP"

  # dest is the temp after renaming
  dest=($(cat "$TEMP"))

  safety_control

  count=0
  # Rename all files line by line with mv
  for ((i = 0; i < ${#src[@]}; i++)); do
      if [ "${src[i]}" != "${dest[i]}" ]; then
          $MOVE_CMD "${src[i]}" "${dest[i]}"
          ((count++))
      fi
  done

  echo "$count" files renamed.

  rm "$TEMP"
}

main "$@"

exit 0
