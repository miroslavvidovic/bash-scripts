#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      eclipseman.sh
#   created:   26.04.2016.-20:12:12
#   revision:  24.07.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Requirements:
#
# Description:
#   Script enables you to have multiple versions of eclipse and to choose which
#   one to start from the terminal.
# Usage:
#   eclipseman.sh
# -----------------------------------------------------------------------------
# Script:

# Export any settings needed to run eclipse
# fix broken menu
export UBUNTU_MENUPROXY=0

# Path to parent directory for all eclipse versions
ECLIPSEPATH=$HOME/Eclipse

# Script expects the following directory structure
# ~/Eclipse
# ├── eclipse-ccpp
# │   └── eclipse
# │       ├── configuration
# │       ├── dropins
# │       ├── eclipse
# │       ├── eclipse.ini
# │       ├── icon.xpm
# │       ├── notice.html
# │       ├── plugins
# │       └── readme
# ├── eclipse-java
#     └── eclipse
#         ├── configuration
#         ├── dropins
#         ├── eclipse
#         ├── eclipse.ini
#         ├── icon.xpm
#         ├── plugins
#         └── readme

# Form an absolute path to eclipse executable by combining
# the fixed part ($HOME/Eclipse) + option + /eclipse/eclipse
# and start eclipse
start_eclipse(){
  "$ECLIPSEPATH"/"$1"/eclipse/eclipse 2>/dev/null 1>/dev/null &
}

main(){

  array=($(ls "$ECLIPSEPATH"/))

  PS3='Please enter your choice: '
  select option in "${array[@]}"; do
    case "$option" in
      "")
        echo "Not a valid option. Exiting."
        break
        ;;
      *) echo "${option}"
         start_eclipse "$option"
         break
        ;;
    esac
  done
}

main "$@"

exit 0
