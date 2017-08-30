#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      my-services.sh
#   created:   24.04.2016.-12:58:46
#   revision:  29.08.2017.
#   version:   1.4
# -----------------------------------------------------------------------------
# Requirements:
#   systemctl
# Description:
#   Check the status of local services.
# Usage:
#   my-services.sh
# -----------------------------------------------------------------------------
# Script:

# Colors
RedText='\033[1;31m'
GreenText='\033[1;32m'
BlueText='\033[1;34m'
EndColor='\e[0m'

# Services to check
services=(apache2.service mysql.service mongodb.service couchdb.service \
          monit.service docker.service ssh.service)

# Separator line
separator(){
  printf '%40s\n' | tr ' ' -
}

# Check each function with builtin systemctl is-active and if a service
# is active print the status in green color. If a service is not active
# print the status in red.
check_service_status(){
  status=$(systemctl is-active "$1")
  if [ "$status" == "active" ]; then
    printf "$BlueText%15s$EndColor %7s $GreenText%15s$EndColor\n" \
      "$1" "=>" "$status"
  else
    printf "$BlueText%15s$EndColor %7s $RedText%15s$EndColor\n" \
      "$1" "=>" "$status"
  fi
}

main(){
  separator
  for service in "${services[@]}"; do
    check_service_status "$service"
    separator
  done
}

main

exit 0
