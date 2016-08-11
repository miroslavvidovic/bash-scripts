#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	findlarge.sh
# 	11.08.2016.-13:20:38
# -------------------------------------------------------
# Description:
#   This script is used to search for files which
# are larger than $1 megabytes. The search starts at
# the current directory that the user is in, ‘pwd‘, and
# includes files in and below the user’s current directory.
# The output is both displayed to the user and stored
# in a file for later review
#
# Usage:
#
# -------------------------------------------------------
# Script:

usage(){
  printf "
  \n***************************************
  \n\nUSAGE:
  .ksh [Number_Of_Meg_Bytes]
  \nEXAMPLE: filelarge.ksh 5
  \n\nWill Find Files Larger Than 5 Mb in, and Below, the \
  irectory...
  \n\nEXITING...\n
  \n***************************************
  "
  exit
}

cleanup(){
  printf "
  \n********************************************************
  \n\nEXITING ON A TRAPPED SIGNAL...
  \n\n********************************************************\n
  "
  exit
}

# Trap a signal and exit
# show cleanup function message
trap 'cleanup' 1 2 3 15

# Checking input and show help for invalid input
if [ $# -ne 1 ]
then
  usage
fi

if [ $1 -lt 1 ]
then
  usage
fi

# Info for the report
# Hostname of this machine
THISHOST=`hostname`
# Timestamp
DATESTAMP=`date +"%h%d:%Y:%T"`
# Top level directory to search
SEARCH_PATH=`pwd`
# Number of Mb for file size trigger
MEG_BYTES=$1
# Data storage file
DATAFILE="/tmp/filesize_datafile.out"
# Initialize to a null file
>$DATAFILE
# Output user file
OUTFILE="largefiles.report"
# Initialize to a null file
>$OUTFILE
# Temporary storage file
HOLDFILE="/tmp/temp_hold_file.out"
# Initialize to a null file
>$HOLDFILE

# Prepare the output user file
echo -e "\n\nSearching for Files Larger Than ${MEG_BYTES}Mb starting in:"
echo -e "\n==> $SEARCH_PATH"
echo -e "\n\nPlease Standby for the Search Results..."
echo -e "\n\nLarge Files Search Results:" >> $OUTFILE
echo -e "\nHostname of Machine: $THISHOST" >> $OUTFILE
echo -e "\nTop Level Directory of Search:" >> $OUTFILE
echo -e "\n==> $SEARCH_PATH" >> $OUTFILE
echo -e "\nDate/Time of Search: ‘date‘" >> $OUTFILE
echo -e "\n\nSearch Results Sorted by Time:" >> $OUTFILE

############################################
# Search for files > $MEG_BYTES starting at the $SEARCH_PATH
find $SEARCH_PATH -type f -size +${MEG_BYTES}000000c -print > $HOLDFILE

# How many files were found?
if [ -s $HOLDFILE ]
then
  NUMBER_OF_FILES=`cat $HOLDFILE | wc -l`
  echo -e "\n\nNumber of Files Found: ==> \
  $NUMBER_OF_FILES\n\n" >> $OUTFILE

  # Append to the end of the Output File...
  ls -lt `cat $HOLDFILE` >> $OUTFILE

  # Display the Time Sorted Output File...
  less $OUTFILE

  echo -e "\n\nThese Search Results are Stored in ==> $OUTFILE"
  echo -e "\n\nSearch Complete...EXITING...\n\n\n"
else
  cat $OUTFILE
  echo -e "\n\nNo Files were Found in the Search Path that"
  echo -e "are Larger than ${MEG_BYTES}Mb\n\n"
  echo -e "\nEXITING...\n\n"
fi

exit 0

