#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	process_csv_files.sh
# 	11.08.2016.-11:17:46
# -------------------------------------------------------
# Description:
#   Script processes multiple csv files and merges them to
#   one file.
#   data/branch_records_fixed.lst is a file containing the
#   list of files that will be processed by the script.
#   data/branch1.dat
#   data/branch2.dat
# Usage:
#
# -------------------------------------------------------
# Script:

# This variable defines the directory to use for data
DATADIR=data
# Merged file
MERGERECORDFILE=${DATADIR}/mergedrecords_fixed.$(date +%m%d%y)
# Zero out the file to start
>$MERGERECORDFILE

# File containing a list of csv files to process
RECORDFILELIST=${DATADIR}/branch_records_fixed.lst
# Output
OUTFILE=${DATADIR}/post_processing_fixed_records.dat
# Zero out the file to start
>$OUTFILE

# This variable defines the field delimiter for fixed-length records
FD=:

# Update field with a new date
NEW_DATEDUE=01312018

# Process file and extract data to variables
process_data_from_file(){
  # Local positional variables
  branch=$1
  account=$2
  name=$3
  total=$4
  datedue=$5
  recfile=$6
  new_datedue=$7

  echo "${branch}${FD}${account}${FD}${name}${FD}${total}\
  ${FD}${new_datedue}${FD}${recfile}" >> $OUTFILE
}

# Merge records to a new file
merge_records(){
  while read RECORDFILENAME
  do

  sed s/$/${FD}$(basename $RECORDFILENAME 2>/dev/null)/g $RECORDFILENAME >> $MERGERECORDFILE

  done  < $RECORDFILELIST
}


parse_data(){

  # Zero out the $OUTFILE
  >$OUTFILE

  # Associate standard output with file descriptor 4
  # and redirect standard output to $OUTFILE
  exec 4<&1
  exec 1> $OUTFILE

  while read RECORD
  do
     # On each loop iteration extract the data fields
     # from the record as we process the record file
     # line by line

     echo $RECORD | awk -F : '{print $1, $2, $3, $4, $5, $6}' \
                  | while read BRANCH ACCOUNT NAME TOTAL DATEDUE RECFILE
     do
         # Perform some action on the data

         process_data_from_file $BRANCH $ACCOUNT $NAME \
                 $TOTAL $DATEDUE $RECFILE $NEW_DATEDUE
         if (( $? != 0 ))
         then
             # Note that $LOGFILE is a global variable
             echo "Record Error: $RECORD" | tee -a $LOGFILE
         fi
     done

  done < $MERGERECORDFILE

  # Restore standard output and close file
  # descriptor 4

  exec 1<&4
  exec 4>&-
}

main(){
  merge_records
  parse_data
}

main

exit 0
