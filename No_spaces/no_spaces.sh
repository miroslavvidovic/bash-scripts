#!/bin/bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	no_spaces.sh
# 	20.02.2016.-15:43:46
# -------------------------------------------------------
# Description:
#   Script to convert spaces in file names to underscores.
# Usage:
#   no_spaces.sh  file\ name.txt
#   returns file_name.txt
#
#   no_spaces.sh --all
#   rename all the files in the current directory
#
#   no_spaces.sh --help
#   show help options
# -------------------------------------------------------
# Script:


function display_help() {
  echo "Usage: interactive_options [options] [argv ...]"
  echo "bash no_spacse.sh --help -->  Display help"
  echo "bash no_spacse.sh --all  -->  Rename all files in the directory"
  echo "bash no_spaces.sh file name -->  Rename one file "

}

function rename_whole_directory(){
  ls | while read -r FILE
  do
     mv -v "$FILE" `echo $FILE | tr ' ' '_' `
  done
}

function rename_one_file(){
  FILE=$1
  mv -v "$FILE" `echo $FILE | tr ' ' '_' `
}

# Parsing command line arguments
if [ "$1" != "" ]
then
  case $1 in
    --help)
      display_help
      exit 1
      ;;
    --all)
      rename_whole_directory
      exit 1
      ;;
    *)
      rename_one_file "$1"
      exit 1
  esac
fi


exit 0
