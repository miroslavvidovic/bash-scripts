#!/bin/bash

# Bash script generating a template script
# script takes a script name as input and returns a text file
# representing a bash script
#
# EXAMPLE:
# bash template.sh new_script.sh
# generates the new_script.sh file

# Name of the script from the firt param
SCRIPTNAME=$1

# Shebang for bash
SHEBANG="#!/usr/bin/env bash"
INFO="Info:"
# Author
AUTHOR="author:    Miroslav Vidovic"
# Date and time when the file was created
DATE="created:   `date +%d.%m.%Y.-%H:%M:%S`"
# File name
FILE="file:      $SCRIPTNAME"
# Revision
REVISION="revision:  ---"
# Version
VERSION="version:   1.0"
# Separator
SEPARATOR=$(printf '%77s\n' | tr ' ' -)
# Requirements
REQUIREMENTS="Requirements: ---"
# Description
DESC="Description:"
SCRIPT="Script:"
EXIT="exit 0"
USAGE="Usage:"
comment="# "

txt="$SHEBANG\n\n"
txt="$txt$comment$SEPARATOR\n"
txt="$txt$comment$INFO\n"
txt="$txt$comment  $AUTHOR\n"
txt="$txt$comment  $FILE\n"
txt="$txt$comment  $DATE\n"
txt="$txt$comment  $REVISION\n"
txt="$txt$comment  $VERSION\n"
txt="$txt$comment$SEPARATOR\n"
txt="$txt$comment$REQUIREMENTS\n"
txt="$txt$comment\n"
txt="$txt$comment$DESC\n"
txt="$txt$comment\n"
txt="$txt$comment$USAGE\n"
txt="$txt$comment\n"
txt="$txt$comment$SEPARATOR\n"
txt="$txt$comment$SCRIPT\n\n"
txt="$txt$EXIT\n"

# Check if the script name is not empty
if [ -z "$SCRIPTNAME" ]; then
  echo "You need to enter the name of the bash script."
else
  printf "$txt" > $SCRIPTNAME
fi

exit 0
