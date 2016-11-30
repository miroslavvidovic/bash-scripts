#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	local_network.sh
# 	30.11.2016.-20:01:36
# -----------------------------------------------------------------------------
# Description:
#  Scan the local network for active IP addresses
# Usage:
# 
# -----------------------------------------------------------------------------
# Script:

declare -a IPs=($(sudo arp-scan --localnet --numeric --quiet --ignoredups | grep -E '([a-f0-9]{2}:){5}[a-f0-9]{2}' | awk '{print $1}'))

for ip in "${IPs[@]}"; do
  echo $ip
done

exit 0
