#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      iponmap.sh
#   created:   04.07.2017.-10:57:21
#   revision:
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   xdg-open
# Description:
#   Display the IP address location on a map (https://en.iponmap.com)
# Usage:
#   iponmap.sh ip_address
# -----------------------------------------------------------------------------
# Script:

check_for_empty_address(){
  if [[ -z $ip ]]; then
    echo "No IP address provided"
    exit 1
  fi
}

check_dependecies(){
  dependencies=(xdg-opens)

  for i in "${dependencies[@]}"; do
    if ! hash "$i" 2>/dev/null; then
      echo "Error: You should install $i for the script to work properly"
    fi
  done
}

# Check if the IP address is valid
# returns 0 if the address is valid and 1 if not
valid_ip(){
  local ip=$1
  local stat=1

  if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    OIFS=$IFS
    IFS='.'
    ip=($ip)
    IFS=$OIFS
    [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
      && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
    stat=$?
  fi
  return $stat
}

main(){
  ip=$1

  check_dependecies

  check_for_empty_address

  if valid_ip $ip; then
    xdg-open https://en.iponmap.com/$ip
  else
    echo "The address you have provided is not a valid IP address"
  fi
}

main "$@"

exit 0
