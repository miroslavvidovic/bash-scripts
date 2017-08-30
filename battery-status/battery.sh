#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      battery.sh
#   created:   12.10.2016.-16:26:32
#   revision:  30.08.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Description:
#   Battery status with output in colors.
# Usage:
#   Set the correct path to your system battery status directory
#   battery_path=/sys/class/power_supply/BAT0
# Credit:
#   https://github.com/Goles/Battery
# -----------------------------------------------------------------------------
# Script:

# For default behavior
setDefaults() {
  green=$(tput setaf 2)
  yellow=$(tput setaf 3)
  red=$(tput setaf 1)
  blue=$(tput setaf 4)
  battery_path=/sys/class/power_supply/BAT0
}

battery_charge() {
  battery_state=$(cat $battery_path/status)
  battery_full=$battery_path/charge_full
  battery_current=$battery_path/charge_now
  if [ "$battery_state" == 'Discharging' ]; then
    BATT_CONNECTED=0
  else
    BATT_CONNECTED=1
  fi
  now=$(cat $battery_current)
  full=$(cat $battery_full)
  BATT_PCT=$((100 * now / full))
}

# Apply the correct color to the battery status prompt
apply_colors() {
  # battery above 75 (great)
  if [[ $BATT_PCT -ge 75 ]]; then
    COLOR=$green

  # battery between 50 and 75 (good)
  elif [[ $BATT_PCT -ge 50 ]] && [[ $BATT_PCT -lt 75 ]]; then
    COLOR=$blue

  # battery between 25 and 50 (ok)
  elif [[ $BATT_PCT -ge 25 ]] && [[ $BATT_PCT -lt 50 ]]; then
    COLOR=$yellow

  # battery below 25 (bad)
  elif [[ $BATT_PCT -lt 25 ]]; then
    COLOR=$red
  fi
}

print_status() {
  # Print the battery status
  # If charger connected
  if ((BATT_CONNECTED)); then
    GRAPH="⚡"
  else
    GRAPH="|"
  fi

  echo "$COLOR" "[$BATT_PCT%]" "$GRAPH"
}

main() {
  setDefaults
  battery_charge
  apply_colors
  print_status
}

main

exit 0
