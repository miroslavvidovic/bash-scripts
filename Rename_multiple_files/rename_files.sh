#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	rename_files.sh
# 	30.06.2016.-13:20:15
# -------------------------------------------------------
# Description:
#   Rename multiple files.
#   In this example all files with the .jpg extension will
#   be renamed to restaurant.picture_number.jpg.
# Usage:
#
# -------------------------------------------------------
# Script:

FILES=`ls *.jpg`
count=0
new_name="restaurant"

for FILE in ${FILES}
{
  # Increase the counter
  count=$((count+1))
  # Base name of the file withouth the extension
  BASE=`basename ${FILE} .jpg`
  # Rename the file
  mv -v ${FILE} $new_name.$count.jpg
}

exit 0
