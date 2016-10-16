#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	battery.sh
# 	12.10.2016.-16:26:32
# -----------------------------------------------------------------------------
# Description:
#   Battery status with output in colors.
# Usage:
#   bash battery.sh
# Credit:
#   https://github.com/Goles/Battery
# -----------------------------------------------------------------------------
# Script:

# For default behavior
setDefaults() {
  good_color="1;32"
  middle_color="1;33"
  warn_color="0;31"
  battery_path=/sys/class/power_supply/BAT0
}

setDefaults

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
# Green
if [[ $BATT_PCT -ge 75 ]]; then
  COLOR=$good_color

# Yellow
elif [[ $BATT_PCT -ge 25 ]] && [[ $BATT_PCT -lt 75 ]]; then
  COLOR=$middle_color

# Red
elif [[ $BATT_PCT -lt 25 ]]; then
  COLOR=$warn_color
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

  printf "\e[0;%sm%s %s \e[m\n"  "$COLOR" "[$BATT_PCT%]"  "$GRAPH"
}

battery_charge
apply_colors
print_status

exit 0
