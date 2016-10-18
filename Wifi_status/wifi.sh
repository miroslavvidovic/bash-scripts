#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	wifi_stat.sh
# 	16.10.2016.-16:15:00
# -----------------------------------------------------------------------------
# Description:
#   Check your wifi signal quality. If your wifi interface is not wlo1 set the
#   global variable INTERFACE to your value. Check wifi interfaces with iwconfig.
# Usage:
#   bash wifi_stat.sh
#   example output:
#   [100%] "miko" 
#   quality and wifi name in the appropriate color
# -----------------------------------------------------------------------------
# Script:

readonly INTERFACE=wlo1

set_colors() {
  good_color="1;38;5;10"
  ok_color="1;38;5;190"
  notgood_color=";38;5;11"
  warn_color="1;38;5;196"
  rbad_color="1;38;5;88"
}

set_colors

get_signal(){
if [ "$(ifconfig $INTERFACE | grep UP | wc -l) -eq 1" ]; then
  link_quality="$(iwconfig $INTERFACE | grep Quality | cut -d'=' -f2 | cut -d' ' -f1 | cut -d'/' -f1)"
  link_name="$(iwconfig $INTERFACE | grep ESSID | cut -d':' -f2)"

  SIGNAL_QUALITY=$(($link_quality * 100 / 70))
  # > 75% quality
  if [ $SIGNAL_QUALITY -gt 75 ]; then 
    COLOR=$good_color
  # > 50% quality
  elif [ $SIGNAL_QUALITY -gt 50 ]; then
    COLOR=$ok_color
  # > 25% quality
  elif [ $SIGNAL_QUALITY -gt 25 ]; then
    COLOR=$notgood_color
  elif [ $SIGNAL_QUALITY -gt 0 ]; then
  # 0-25% link qual
    COLOR=$warn_color
  else # < 25%
    COLOR=$rbad_color
  fi

  printf "\e[0;%sm%s %s \e[m\n"  "$COLOR" "[$SIGNAL_QUALITY%]" "$link_name"

fi
}

get_signal

exit 0
