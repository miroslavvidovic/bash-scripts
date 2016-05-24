#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	term-colors.sh
# 	24.05.2016.-18:13:19
# -------------------------------------------------------
# Description:
#   Create the colors available for usage in the terminal
#   and name them with their number.
# Usage:
#   term-colors.sh
# -------------------------------------------------------
# Script:

colors(){
  for i in {0..255} ; do
      printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

colors

exit 0
