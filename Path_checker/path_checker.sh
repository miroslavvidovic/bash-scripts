#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	path_chacker.sh
# 	13.12.2016.-14:20:20
# -----------------------------------------------------------------------------
# Description:
#   Check the system path. 
# Usage:
# 
# -----------------------------------------------------------------------------
# Script:

# Colors
green=$(tput setaf 2)
red=$(tput setaf 1)
normal=$(tput sgr0)

exit_code=0

for dir in ${PATH//:/ }; do
  [ -L "$dir" ] && printf "%b" "symlink, "
  if [ ! -d "$dir" ]; then
    printf "%b" "${red}missing${normal}\t\t\t\t"
    (( exit_code++ ))
  else
    stat=$(ls -lHd $dir | awk '{print $1, $3, $4}')
    if [ "$(echo $stat | grep '^d.......w. ')" ]; then
      printf "%b" "world writable\t$stat "
      (( exit_code++ ))
    else
      printf "%b" "${green}ok\t\t${normal}$stat"
    fi
  fi
  printf "%b" "$dir\n"
done

exit $exit_code
