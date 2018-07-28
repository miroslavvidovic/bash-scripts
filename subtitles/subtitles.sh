#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      subtitles.sh
#   created:   14.10.2016.-20:58:57
#   revision:  28.07.2018.
#   version:   1.4
# -----------------------------------------------------------------------------
# Requirements:
#   subliminal
# Description:
#   A small wrapper script for subliminal
#   https://github.com/Diaoul/subliminal
# Usage:
#   subtitles.sh movie_name.mp4
# -----------------------------------------------------------------------------
# Script:

# remove [], -, and subtitute webrip with web because webrip is incorrectly
# parsed as a list of web and rip by guessit which leads to errors in subliminal
remove_characters(){
  local name="$1"
  local clean_name
  clean_name=$(echo "$name" | sed -e 's/\[//g' -e 's/\]//g' \
    -e 's/\-/./g' \
    -e 's/webrip/web/g')
  echo "$clean_name"
}

main(){
  # Check if subliminal is installed
  hash subliminal 2>/dev/null || { 
    echo >&2 "Subliminal required but it's not installed.  Aborting."; exit 1; 
  }

  # Check for empty input
  if [[ $# -eq 0 ]]; then
      echo "No arguments supplied"
  else

    name=$(remove_characters "$@")

    # Download English, Serbian, German and Spanish subtitles
    subliminal download -l en -l srp -l de -l es "$name"

    # Send notification if notify-send is available
    if hash notify-send 2>/dev/null; then
      notify-send --icon="dialog-information" \
        --urgency="critical" "Subtitles.sh finished"
    fi

    # If sound.sh script is available use it to play a sound
    if hash sound.sh 2>/dev/null; then
      sound.sh
    fi
  fi
}

main "$@"

exit 0
