#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	finfo.sh
# 	25.06.2016.-14:47:34
# -------------------------------------------------------
# Description:
#   Show detailed file info using 3 tools:
#   -file
#   -wc
#   -stat
# Usage:
#   finfo.sh -i some_file.py
# -------------------------------------------------------
# Script:

# file=$1
separator="--------------------------------------------------------------------"

help(){
  cat<< EOF
  Show detailed information for a file.
    Usage:
  ------
  $0
  -i
    Show information
  -h
    Show this help
EOF

}

check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      echo "No input"
      help
      exit 0
    fi
}

file_info(){
  file $file
  echo $separator
}

wc_info(){
  echo "lines/words/characters"
  wc $file
  echo $separator
}

stat_info(){
  stat $file
  echo $separator
}

all_info(){
  echo "File info"
  echo $separator
  file_info
  wc_info
  stat_info
}

main(){
  while getopts 'i:h' flag; do
      case "${flag}" in
        i)
          file=${OPTARG}
          all_info $file ;;
        h) help ;;
      esac
    done
}

check_for_empty_input "$@"
main "$@"

exit 0
