#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	local_network.sh
# 	30.11.2016.-20:01:36
# -----------------------------------------------------------------------------
# Description:
#  Scan the local network for active IP addresses.
# Usage:
# 
# -----------------------------------------------------------------------------
# Script:

# Check if nmap is available
nmap_check(){
  hash nmap 2>/dev/null || { echo >&2 "This script requires nmap to run correctly. "; \
    exit 1; }
}

# Returns the current machine ip address
# @returns IP
my_ip(){
  local myip
  myip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
  echo "$myip"
}

# Scans the local network for active IP addresses and store them in an array
# @returns (array) ips - array of active ip addresses
active_ips(){
  # Active ip addresses array
  declare -a ips=($(nmap -nsP 192.168.1.0/24 2>/dev/null -oG - | grep "Up$" | awk '{printf "%s ", $2}'))
  echo "${ips[@]}"
}

main(){
  nmap_check

  local myip=$(my_ip)
  local IPs=($(active_ips))

  local green_foreground="$(tput setaf 2)"
  local color_reset="$(tput sgr0)"

  for ip in "${IPs[@]}"; do
    if [[ $ip == "$myip" ]]; then
      echo "$green_foreground$ip" "<- My IP" "$color_reset"
    else 
      echo "$ip"
    fi
  done
}

main

exit 0
