#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	archive_list.sh
# 	27.08.2016.-17:19:31
# -----------------------------------------------------------------------------
# Description:
#   Archive files and directories specified in the Files_To_Backup conf file
#   with the tar command. The archive will be stored in the DESTINATION.
# Usage:
#   Make a list in the conf file and run the script with
#     archive_list.sh
# -----------------------------------------------------------------------------
# Script:

# Current date
DATE=$(date +%d%m%y)

# Set Archive File Name
FILE=archive$DATE.tar.gz

# Set Configuration and Destination File
CONFIG_FILE=Files_To_Backup
DESTINATION=archive/$FILE

# Check does the config file exist before Continuing
check_config_file(){
  # Make sure the config file still exists.
  if [ -f $CONFIG_FILE ]
  then
  # If it exists, do nothing but continue on.
    echo
  # If it doesn't exist, issue error & exit script.
  else
    echo
    echo "$CONFIG_FILE does not exist."
    echo "Backup not completed due to missing Configuration File"
    echo
    exit 1
  fi
}

main(){

  check_config_file

  # Build the names of all the files to backup
  FILE_NO=1

  # Start on Line 1 of Config File.
  exec < $CONFIG_FILE
  # Redirect Std Input to name of Config File
  # Read 1st record
  read FILE_NAME

  # Create list of files to backup.
  while [ $? -eq 0 ]
  do
      # Make sure the file or directory exists.
      if [ -f $FILE_NAME -o -d $FILE_NAME ]
      then
        # If file exists, add its name to the list.
        FILE_LIST="$FILE_LIST $FILE_NAME"
      else
        # If file doesn't exist, issue warning
        echo
        echo "$FILE_NAME, does not exist."
        echo "Obviously, I will not include it in this archive."
        echo "It is listed on line $FILE_NO of the config file."
        echo "Continuing to build archive list..."
        echo
      fi
      # Increase Line/File number by one.
      FILE_NO=$[$FILE_NO + 1]
      read FILE_NAME
  done

  # Backup the files and Compress Archive
  echo -e "Starting archive...\n\n"

  tar -czf $DESTINATION $FILE_LIST 2> /dev/null
  echo "Archive completed"
  echo -e "Resulting archive file is: $DESTINATION\n\n"
}

main

exit 0
