#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      pomodoro-timer.sh
#   created:   09.07.2017.-13:42:37
#   revision:
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#
# Description:
#   Simple pomodoro timer implementation in bash.
#   https://en.wikipedia.org/wiki/Pomodoro_Technique
# Usage:
#   duration (minutes)
#   pomodoro-timer.sh number_of_sesions work_duration rest_durations
# -----------------------------------------------------------------------------
# Script:

# Set the parameters based on the user input or default values
# default: one sesion - 25 minutes of work and 5 minutes of rest
set_params(){
  # Get the user input if any is available
  iterations="$1"
  work_duration="$2"
  rest_duration="$3"

  # Set the default values
  if [[ -z "$iterations" ]]; then
    iterations=1
  fi

  if [[ -z "$work_duration" ]]; then
    work_duration=$((25*60))
  else
    work_duration=$((work_duration*60))
  fi

  if [[ -z "$rest_duration" ]]; then
    rest_duration=$((5*60))
  else
    rest_duration=$((rest_duration*60))
  fi
}

# Run a session
session(){
  duration="$1"
  session_type="$2"
  while [[ 0 -ne "$duration" ]]; do
      echo -ne "$duration seconds left" \\r
      sleep 1
      duration=$((duration-1))
  done
  send_a_notification "$session_type"
}

# Send a notification to the user
send_a_notification(){
  session_type="$1"

  if [[ "$session_type" == "work" ]]; then
    message="Work done. Rest for 5 minutes."
  else
    message="Resting cycle done."
  fi

  paplay /usr/share/sounds/freedesktop/stereo/complete.oga

  notify-send -i face-wink --urgency="critical" "$message"

  zenity --info \
  --text="$message" /dev/null 2>&1
}

main(){
  set_params "$@"

  while [[ 0 -ne "$iterations" ]]; do
    echo "Doing a pomodoro iteration"
    echo "--------------------------"
    session "$work_duration" "work"
    session "$rest_duration" "rest"
    iterations=$((iterations-1))
  done
}

main "$@"

exit 0