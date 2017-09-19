#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      spin-wheel.sh
#   created:   27.08.2016.-12:10:47
#   revision:  19.09.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Description:
#   Show the spinner animation while executing some long command
# Usage:
#   spin-wheel.sh sleep 10
# -----------------------------------------------------------------------------
# Script:

show_spinner() {
  # ID of the process the executing while the spinner is showing
  local -r pid="${1}"
  # Delay for the spinner animation
  local -r delay='0.80'
  # Lines forming the spinner
  local spinstr='|/-\'
  # Emtpy variable
  local temp
  # Disable the cursor for better animation
  tput civis

  # Show the animation while the process is running
  while [ "$(ps a | awk '{print $1}' | grep -w "$pid")" ]; do
    temp="${spinstr#?}"
    printf " [%c]  " "${spinstr}"
    spinstr=${temp}${spinstr%"${temp}"}
    sleep "${delay}"
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
  # Enable the cursor again
  tput cnorm
}

# Trap the exit signal and enable cursor
signal() {
  echo -e "\n\nExiting on trapped signal...\n"
  tput civis
  exit 1
}

trap signal 1 2 3 15

("$@") &
show_spinner "$!"

exit 0
