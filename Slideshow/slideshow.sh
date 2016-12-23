#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      slideshow.sh
#   created:   23.12.2016.-11:12:09
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   ImageMagic
# Description:
#   Create a slideshow from all the images in a directory.
# Usage:
#   slideshow.sh
#
# -----------------------------------------------------------------------------
# Script:


check_input(){
  # 0 parameters given
  if [ $# -eq 0 ] ; then
    echo "Usage: $(basename "$0") watch-directory" >&2
    exit 1
  fi

  watch="$1"
 
  # If watch is not a directory terminate the script
  if [ ! -d "$watch" ] ; then
    echo "$(basename "$0"): Specified directory $watch isn't a directory." >&2
    exit 1
  fi
}

main(){
  # Default delay in seconds
  delay=2
  
  # Preferred image size for display
  psize="1200x600>"

  check_input "$@"

  cd "$watch"
  
  if [ $? -ne 0 ] ; then
    echo "$(basename "$0"): Failed trying to cd into $watch" >&2
    exit 1
  fi
  
  suffixes="$(file * | grep image | cut -d: -f1 | rev | cut -d. -f1 | \
    rev | sort | uniq | sed 's/^/\*./')"
  
  if [ -z "$suffixes" ] ; then
    echo "$(basename "$0"): No images to display in folder $watch" >&2
    exit 1
  fi
  
  echo -n "Displaying $(ls $suffixes | wc -l) images from $watch "
  set -f ; echo "with suffixes $suffixes" ; set +f
  display -loop 0 -delay $delay -resize $psize -backdrop $suffixes
}

main "$@"

exit 0
