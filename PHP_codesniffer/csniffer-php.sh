#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	csniffer-php.sh
# 	12.05.2016.-18:29:10
# -------------------------------------------------------
# Description:
#   Run phpcs (php code sniffer) with my preferred options
# Usage:
#   csniffer-php.sh directory
#   csniffer-php.sh file.php
# -------------------------------------------------------
# Script:


scan(){
  echo "Running php code sniffer"
  phpcs --standard=PSR2 --colors -p $input
}

fix(){
  echo "Running php code fixer"
  phpcbf --standard=PSR2 --encoding=utf-8 $input
}

help(){
  cat<< EOF
  Use PHP CodeSniffer scripts to scan PHP code to PSR2 coding standard and fix errors.
  Usage:
  ------
  $0 [s|f|h] input(directory/file)
  -s
    Scan the file/directory for errors.
  -f
    Auto fix the errors in file/directory.
  -h
    Show this help
EOF
}

main(){
  while getopts 's:f:h' flag; do
    case "${flag}" in
      s)  input=${OPTARG}
          scan ;;
      f)  input=${OPTARG}
          fix ;;
      h) help ;;
    esac
  done
}

check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      help
      exit 0
    fi
}

check_for_empty_input "$@"
main "$@"



exit 0
