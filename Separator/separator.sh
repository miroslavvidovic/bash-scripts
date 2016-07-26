#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	separator.sh
# 	26.07.2016.-11:13:15
# -------------------------------------------------------
# Description:
#   Print a separator line wide as the terminal width using
#   a custom character for the line.
# Usage:
#   separator "#" ( prints a line of #  )
# -------------------------------------------------------
# Script:

character=$1

separator(){
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' $character
}

separator

exit 0
