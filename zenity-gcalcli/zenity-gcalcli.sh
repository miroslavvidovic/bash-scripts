#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      zenity-gcalcli.sh
#   created:   12.02.2017.-14:56:47
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   gcalcli zenity
#
# Description:
#   Add Google calendar events with gcalcli and zenity forms.
# Usage:
#   zenity-gcalcli.sh
# -----------------------------------------------------------------------------
# Script:

# Gmail account
readonly GMAIL="vidovic.miroslav.vm@gmail.com"

check_dependencies() {
  local dependencies=(gcalcli zenity)

  for i in "${dependencies[@]}"; do
    if ! [ -x "$(command -v "$i")" ]; then
      zenity --error \
        --text="Error: $i is not installed."
      exit 1
    fi
  done
}

insert_with_zenity() {
  # Show the form
  OUTPUT=$(zenity --forms --title="Add a new task"\
                  --text="Enter task details"\
                  --separator=","\
                  --add-entry="Title"\
                  --add-calendar="Due date"\
                  --add-entry="Time 00:00 - 24:00"
                  )
  accepted=$?
  if ((accepted != 0)); then
      echo "something went wrong"
      exit 1
  fi

  # Get the data from the form
  title=$(awk -F, '{print $1}' <<<$OUTPUT)
  date=$(awk -F, '{print $2}' <<<$OUTPUT)
  time=$(awk -F, '{print $3}' <<<$OUTPUT)

  # Extract day and month from the date
  day=$(echo "$date" | cut -d "." -f 1 | tr "'" " ")
  month=$(echo "$date" | cut -d "." -f 2)

  # Use gcalcli to add a quick task to google calendar
  gcalcli --calendar $GMAIL quick "$title at $time $month/$day"
}

main() {
  check_dependencies
  insert_with_zenity
}

main

exit 0
