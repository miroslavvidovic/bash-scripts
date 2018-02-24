#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      unblock-packmanager.sh
#   created:   24.02.2018.-16:10:11
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Description:
#   List and kill all processes blocking dpkg and apt package managers.
#
# -----------------------------------------------------------------------------
# Script:

help(){
cat<< EOF
  usage: $(basename "$0") [-l] [-k] [-h]

  List or kill processes blocking apt or dpkg.
  ------
  -l
    List processes blocking apt or dpkg
  -k
    Kill all process blocking apt or dpkg
  -h
    Show this help message
EOF
}

# List of processes blocking apt
find_processes(){
  processes=($(pgrep -f 'dpkg|apt'))
}

list_processes(){
  find_processes
  for process in "${processes[@]}"; do
    ps -p "$process" -o pid,vsz=MEMORY -o user,group=GROUP -o comm,args=ARGS
  done
}

kill_processes(){
  for process in "${processes[@]}"; do
    sudo kill -9 "$process"
  done
}

check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      echo -e "Invalid command\n"
      help
      exit 0
    fi
}

main(){
  check_for_empty_input "$@"
  while getopts 'lkh' flag; do
    case "${flag}" in
      l) list_processes ;;
      k) kill_processes ;;
      h) help ;;
      *) echo -e "\n"; help ;;
    esac
  done
shift "$((OPTIND - 1))" 
}

main "$@"

exit 0
