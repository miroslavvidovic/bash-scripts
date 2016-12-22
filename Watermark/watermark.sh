#!/bin/bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      watermark.sh
#   created:   22.12.2016.-17:20:07
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   ImageMagic
# Description:
#   Adds specified text as a watermark on the input image,saving the output as 
#   image+wm.
# Usage:
#   watermark.sh imagefile "watermark text"
#
# -----------------------------------------------------------------------------
# Script:

# No temp file left behind
cleanup(){
  $(which rm) -f $wmfile
}

# Check the input parameters.
# Terminate the script if the number of parameters is not equal to 2 or if the 1
# parameter doesn't  exist or is not readable.
check_input(){
  if [ $# -ne 2 ] ; then
    echo "Usage: $(basename $0) imagefile \"watermark text\"" >&2
    exit 1
  fi

  if [ ! -r "$1" ] ; then
    echo "$(basename $0): Can't read input image $1" >&2
    exit 1
  fi
}

main(){
  trap cleanup 0 1 15
  check_input "$@"

  # temp file
  wmfile="/tmp/watermark.$$.png"
  # font size for the watermark text
  fontsize="24"

  # To start, get the dimensions of the image.
  dimensions="$(identify -format "%G" "$1")"

  # Create the temporary watermark overlay.
  convert -size $dimensions xc:none -pointsize $fontsize -gravity south \
    -draw "fill black text 1,1 '$2' text 0,0 '$2' fill white text 2,2 '$2'" \
    $wmfile

  # Composite the overlay and the original file.
  suffix="$(echo $1 | rev | cut -d. -f1 | rev)"
  prefix="$(echo $1 | rev | cut -d. -f2- | rev)"
  newfilename="$prefix+wm.$suffix"
  composite -dissolve 75% -gravity south $wmfile "$1" "$newfilename"
  echo "Created new watermarked image file $newfilename."
}

main "$@"

exit 0
