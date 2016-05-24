#!/bin/bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	free_space.sh
# 	14.04.2016.-09:40:03
# -------------------------------------------------------
# Description:
#   Script summarizes available disk space and presents
#   it in a human readable form.
# Usage:
#   free_space.sh
# -------------------------------------------------------
# Script:

tempfile="/tmp/available.$$"

trap "rm -f $tempfile" EXIT

cat <<'EOF'>$tempfile
  { sum += $4  }
END { mb = sum / 1024
  gb = mb / 1024
  printf "%.0f MB (%.2fGB) of available disk space\n", mb, gb
}
EOF

df -k | awk -f $tempfile

exit 0
