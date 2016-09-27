#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	timestamp.sh
# 	19.08.2016.-14:43:05
# -----------------------------------------------------------------------------
# Description:
#   Creating a timestamp in 4 different formats. Can be useful for unique file
#   names or similar stuff.
# Usage:
#
# -----------------------------------------------------------------------------
# Script:

# Timestamp time
timestamp() {
  date +"%T"
}

# Timestamp date time
timestamp2(){
  date +"%d.%m.%Y._%H:%M:%S"
}

# Timestamp since the epoch
# seconds since 1970-01-01 00:00:00 UTC
timestamp3(){
  date +"%s"
}

# Timestamp since the epoch
# seconds since 1970-01-01 00:00:00 UTC + nanoseconds
timestamp4(){
  date +"%s%N"
}

timestamp
timestamp2
timestamp3
timestamp4

exit 0

