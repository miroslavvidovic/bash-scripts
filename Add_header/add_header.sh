#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	add_header.sh
# 	19.12.2016.-12:27:34
# -----------------------------------------------------------------------------
# Description:
#   Add the info header to an existing bash script.
# Usage:
#   add_header.sh script_name.sh
# -----------------------------------------------------------------------------
# Script:

input_file=$1

timestamp=$(date +"%d.%m.%Y.-%H:%M:%S")

sed -i -e "1i#!/usr/bin/env bash\n\n\
# -----------------------------------------------------------------------------\n\
# Info:\n\
#   author:    Miroslav Vidovic\n\
#   file:      $input_file\n\
#   created:   $timestamp\n\
#   revision:  ---\n\
#   version:   1.0\n\
# -----------------------------------------------------------------------------\n\
# Requirements:\n\
#\n\
# Description:\n\
#\n\
# Usage:\n\
#   $input_file\n\
#\n\
#   Lorem ipsum usage\n\
# -----------------------------------------------------------------------------\n\
# Script:\n" $input_file

