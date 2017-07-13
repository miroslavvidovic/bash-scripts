#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      subtitles.sh
#   created:   14.10.2016.-20:58:57
#   revision:  30.06.2017.
#   version:   1.3
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

main(){
  # Check if subliminal is installed
  hash subliminal 2>/dev/null || { 
    echo >&2 "Subliminal required but it's not installed.  Aborting."; exit 1; 
  }

  # Check for empty input
  if [[ -z "$@" ]]; then
    echo "Input file needed."
  else
    # Download English, Serbian, German and Spanish subtitles
    subliminal download -l en -l srp -l de -l es "$@"

    # Send notification if notify-send is available
    if hash notify-send 2>/dev/null; then
      notify-send --urgency="critical" "Subtitles.sh finished"
    fi

    # If sound.sh script is available use it to play a sound
    if hash sound.sh 2>/dev/null; then
      sound.sh
    fi
  fi
}

main "$@"

exit 0
