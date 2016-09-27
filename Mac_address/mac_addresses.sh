#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	mac_address.sh
# 	19.08.2016.-15:52:11
# -----------------------------------------------------------------------------
# Description:
#   Get the MAC addresses of the device from the ifconfig output.
# Usage:
#
# -----------------------------------------------------------------------------
# Script:

ifconfig | grep HW | awk 'BEGIN { print "Device     MAC address"
                                  print "------     ------" }
                                { printf "%-10s %s\n", $1, $5 }'

exit 0
