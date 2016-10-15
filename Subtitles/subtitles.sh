#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	subtitles.sh
# 	14.10.2016.-20:58:57
# -----------------------------------------------------------------------------
# Description:
#   A small wrapper for subliminal 
#   https://github.com/Diaoul/subliminal
# Usage:
# subtitles.sh movie_name.mp4
# 
# -----------------------------------------------------------------------------
# Script:

main(){
  # Check if subliminal is installed
  hash subliminal 2>/dev/null || { echo >&2 "I require subliminal but it's not installed.  Aborting."; exit 1; }
  # Check for empty input
  if [[ -z $1 ]]; then
    echo "Input file needed."
  else
    # Download English and Serbian subtitles
    subliminal download -l en -l srp $1
    # Send notification
    notify-send "Subtitles.sh finished"
    # If sound.sh script is available use it to play a sound 
    if hash sound.sh 2>/dev/null; then
      sound.sh
    fi
  fi
}

main "$@"

exit 0
