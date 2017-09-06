#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      download-music.sh
#   created:   06.09.2017.-19:14:47
#   revision:
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   youtube-dl
# Description:
#   Download music from youtube
# Usage:
#
# -----------------------------------------------------------------------------
# Script:
download_list="$1"

check_dependency(){
# Check if subliminal is installed
hash "$1" 2>/dev/null || { 
  echo >&2 "$1 required but it's not installed.  Aborting."; exit 1; 
}
}

main(){
  check_dependency youtube-dl

  youtube-dl -o '%(title)s.%(ext)s' --extract-audio --audio-format mp3 --audio-quality 0 -a $download_list --restrict-filenames
}

main

exit 0
