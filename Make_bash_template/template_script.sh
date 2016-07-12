#!/bin/bash

# Bash script generating a template script
# script takes a script name as input and returns a text file
# representing a bash script
# EXAMPLE:
# bash template.sh new_script.sh
# generates the new_script.sh file
#

SHEBANG="#!/usr/bin/env bash"
DATE=`date +%d.%m.%Y.-%H:%M:%S`
AUTHOR="Miroslav Vidovic"
SCRIPTNAME=$1
SEPARATOR="-------------------------------------------------------"
INFO="Info:"
DESC="Description:"
SCRIPT="Script:"
EXIT="exit 0"
USAGE="Usage:"
comment="# "

txt="$SHEBANG\n\n"
txt="$txt$comment$SEPARATOR\n"
txt="$txt$comment$INFO\n"
txt="$txt$comment\t$AUTHOR\n"
txt="$txt$comment\t$SCRIPTNAME\n"
txt="$txt$comment\t$DATE\n"
txt="$txt$comment$SEPARATOR\n"
txt="$txt$comment$DESC\n"
txt="$txt$comment\n"
txt="$txt$comment$USAGE\n"
txt="$txt$comment\n"
txt="$txt$comment$SEPARATOR\n"
txt="$txt$comment$SCRIPT\n\n"
txt="$txt$EXIT\n"

if [ -z "$SCRIPTNAME" ]; then
  echo "You need to enter the name of the bash script."
else
  printf "$txt" > $SCRIPTNAME
fi

exit 0
