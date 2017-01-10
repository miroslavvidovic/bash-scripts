#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      my-services.sh
#   created:   24.04.2016.-12:58:46
#   revision:  28.12.2016.
#   version:   1.1
# -----------------------------------------------------------------------------
# Requirements:
#
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
services=(apache2.service mysql.service mongodb.service couchdb.service monit.service docker.service)

# Separator line
separator(){
  printf '%40s\n' | tr ' ' -
}

# Check each function with builtin systemctl is-active and if a service
# is active print the status in green color. If a service is not active
# print the status in red.
check_service_status(){
  status=$(systemctl is-active $1)
  if [ "$status" == "active" ]; then
    printf "$BlueText $1 is $EndColor $GreenText $status $EndColor \n"
  else
    printf "$BlueText $1 is $EndColor $RedText $status $EndColor \n"
  fi
}

main(){
 separator

 for service in "${services[@]}"
do
  check_service_status $service

  separator
done
}

main

exit 0
