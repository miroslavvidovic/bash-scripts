#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	num-of-commands.sh
# 	27.07.2016.-15:28:05
# -------------------------------------------------------
# Description:
# A simple script to count how many executable commands
#   are in your current PATH.
# Usage:
#
# -------------------------------------------------------
# Script:

myPATH="$(echo $PATH | sed -e 's/ /~~/g' -e 's/:/ /g')"
count=0 ; nonex=0

for dirname in $myPATH ;  do
  directory="$(echo $dirname | sed 's/~~/ /g')"
  if [ -d "$directory" ] ; then
    for command in $(ls "$directory") ; do
      if [ -x "$directory/$command" ] ; then
        count="$(( $count + 1 ))"
      else
        nonex="$(( $nonex + 1 ))"
      fi
    done
  fi
done

echo "$count commands, and $nonex entires that weren't marked executable"

exit 0
