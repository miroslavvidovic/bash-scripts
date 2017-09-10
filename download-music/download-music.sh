#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      download-music.sh
#   created:   06.09.2017.-19:14:47
#   revision:  09.09.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Requirements:
#   youtube-dl
# Description:
#   Download music from youtube
# Usage:
#
# -----------------------------------------------------------------------------
# Script:
SCRIPTNAME=$(basename "$0")

help_message(){
  echo "
  Usage: $SCRIPTNAME [Options] URLFILE

  Download music from youtube.

  URLFILE : file with urls for youtube videos

  Options:
  -h  Show this help message and exit.
  "
}

check_existence(){
  local requirements=("$@")
  for app in "${requirements[@]}"; do
    type "$app" >/dev/null 2>&1 || \
      { echo >&2 "$app is required but it's not installed. Aborting."; exit 1; }
  done
}

check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      echo -e "Error:  No input "
      help_message
      exit 1
    fi
}

main(){
  check_existence youtube-dl

  while getopts 'h' flag; do
    case "${flag}" in
      h)  help_message
          exit 0
          ;;
      *)
         help_message
         exit 1
         ;;
    esac
  done
  shift $((OPTIND-1))

  check_for_empty_input "$@"

  download_list="$1"

  youtube-dl -o '%(title)s.%(ext)s' --extract-audio --audio-format mp3 --audio-quality 0 -a "$download_list" --restrict-filenames
}

main "$@"

exit 0
