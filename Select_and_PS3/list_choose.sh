#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	list_choose.sh
# 	02.09.2016.-09:05:35
# -----------------------------------------------------------------------------
# Description:
#   Example of how to use the bash select command and the PS3 variable.
# Usage:
#   bash list_choose.sh
# -----------------------------------------------------------------------------
# Script:

  directorylist="Finished $(ls /)"

  # Set a useful select prompt with the PS3 variable
  PS3='Directory to process? '
  until [ "$directory" == "Finished" ]; do

    printf "%b" "\a\n\nSelect a directory to process:\n" >&2
    select directory in $directorylist; do

       # User types a number which is stored in $REPLY, but select
       # returns the value of the entry
       if [ "$directory" = "Finished" ]; then
         echo "Finished processing directories."
         break
       elif [ -n "$directory" ]; then
         echo "You chose number $REPLY, processing $directory ..."
         # Do something here
         break
       else
         echo "Invalid selection!"
       fi # end of handle user's selection
    done # end of select a directory
  done # end of while not finished

exit 0
