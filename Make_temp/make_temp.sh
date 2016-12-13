#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	make_temp.sh
# 	13.12.2016.-15:50:03
# -----------------------------------------------------------------------------
# Description:
#   Create temp directories and files with the RANDOM command.
# Usage:
# 
# -----------------------------------------------------------------------------
# Script:

# Make a "good enough" random temp directory
until [ -n "$temp_dir" -a ! -d "$temp_dir" ]; do
  temp_dir="/tmp/mydir.${RANDOM}${RANDOM}${RANDOM}"
done
mkdir -p -m 0700 $temp_dir \
  || { 
      echo "FATAL: Failed to create temp dir '$temp_dir': $?"; 
      exit 100 
     }

# Make a "good enough" random temp file in the temp dir
temp_file="$temp_dir/myfile.${RANDOM}${RANDOM}${RANDOM}"
touch $temp_file && chmod 0600 $temp_file \
  || { 
      echo "FATAL: Failed to create temp file '$temp_file': $?";
      exit 101 
     }

# Do our best to clean up temp files no matter what
# Note $temp_dir must be set before this, and must not change!
cleanup="rm -rf $temp_dir"
# The file and directory wil be cleaned
trap "$cleanup" ABRT EXIT HUP INT QUIT

exit 0
