#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic (miroslav-vidovic@hotmail.com)
#   file:      sbackup.sh
#   created:   01.10.2017.-20:51:30
#   revision:
#   version:   1.0
# -----------------------------------------------------------------------------
# Description:
#   Perform a Linux server backup with tar.
# Usage:
#   sbackup.sh destination
# -----------------------------------------------------------------------------
# Script:

SCRIPTNAME=$(basename "$0")

DESTINATION="$1"

check_for_empty_input(){
  if [ -z "$DESTINATION" ]
    then
      echo "No backup destination given"
      exit 1
  fi
}

main(){
  check_for_empty_input

  tar -zcvpf "$DESTINATION"/full-backup-"$(date '+%d.%m.%Y')".tar.gz \
      --directory / --exclude=mnt --exclude=proc --exclude=var/spool/squid .
}

main "$@"

exit 0
