#!/usr/bin/env bash

# Bash script that generates a template script with the info header.
# Script takes a script name as input and returns a text file, representing
# a new bash script.

# Separator
SEPARATOR=$(printf '%77s\n' | tr ' ' -)

# Shebang for bash
SHEBANG="#!/usr/bin/env bash"

# Author
AUTHOR="Miroslav Vidovic (miroslav-vidovic@hotmail.com)"

# Name of the script from the first parameter
SCRIPTNAME="$1"

# Date and time when the file was created
DATE=$(date +%d.%m.%Y.-%H:%M:%S)

check_input(){
  # Check if the script name is not empty
  if [ -z "$SCRIPTNAME" ]; then
    echo "You need to enter the name of the bash script."
    exit 1
  fi
}

info_header(){
  cat << _EOF_
$SHEBANG

# $SEPARATOR
# Info:
#   author:    $AUTHOR
#   file:      $SCRIPTNAME
#   created:   $DATE
#   revision:
#   version:   1.0
# $SEPARATOR
# Requirements:
#
# Description:
#
# Usage:
#
# $SEPARATOR
# Script:

SCRIPTNAME=\$(basename "\$0")

help_message(){
  echo "Usage :  \$SCRIPTNAME [options] args
    "
}

main(){
  help_message
}

main

exit 0
_EOF_
}

main(){
  check_input
  info_header "$@" > "$SCRIPTNAME"
}

main "$@"

exit 0
