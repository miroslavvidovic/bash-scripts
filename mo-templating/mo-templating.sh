#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      mo-templating.sh
#   created:   04.07.2017.-13:25:06
#   revision:
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   mo (https://github.com/tests-always-included/mo)
# Description:
#   Using a templating engine similar to mustache in bash.
# Usage:
#   Download the mo script, make the script executabe and copy it to the right
#   location.
# -----------------------------------------------------------------------------
# Script:

date=$(date +"%d.%m.%Y.")
name=$(hostname)
uptime=$(uptime -p | cut -d' ' -f2,3,4,5)
disk=$(df -h)

NAME=$name UPTIME=$uptime DATE=$date DISK=$disk ./mo test.mo

exit 0
