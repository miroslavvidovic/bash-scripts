#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      replace-all.sh
#   created:   25.08.2017.-13:19:36
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements: ---
#
# Description:
#
# Usage:
# bash replace-all.sh -n "mladen" -o "miroslav" $(find testing -name '*.py')
# -----------------------------------------------------------------------------
# Script:
help(){
  cat <<'EOF'
  replace-all.sh [new] [old] [files..]
EOF
}

check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      help
      exit 1
    fi
}

if_empty(){
  if [[ "$1" == "" ]]; then
    help
    exit 1
  fi
}

main(){
  check_for_empty_input "$@"

  while getopts 'hn:o:' flag; do
    case "${flag}" in
      n)
        new=${OPTARG}
          ;;
      o)
        old=${OPTARG}
          ;;
      h) help
          ;;
    esac
  done
  shift $((OPTIND-1))

  if_empty "$old" || if_empty "$new"

  for file in "$@"; do
    sed -i "s/$old/$new/g" "$file"
  done
}

main "$@"

exit 0
