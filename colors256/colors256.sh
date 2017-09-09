#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      colors256.sh
#   created:   24.10.2016.-15:05:34
#   revision:  09.09.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Description:
#   Display 256 colors in the terminal.
# Credit:
#   http://misc.flogisoft.com/bash/home
# -----------------------------------------------------------------------------
# Script:

for fgbg in 38 48 ; do #Foreground/Background
  for color in {0..256} ; do #Colors
  #Display the color
  echo -en "\e[${fgbg};5;${color}m ${color}\t\e[0m"
  #Display 10 colors per lines
  if [ $(((color + 1) % 10)) == 0 ] ; then
    echo
  fi
  done
  echo
done

exit 0
