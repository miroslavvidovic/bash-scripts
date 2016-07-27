#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	todo.sh
# 	16.05.2016.-09:47:16
# -------------------------------------------------------
# Description:
#   Simple todo application with csv database and a colorful
#   output. Script is more a test of sed,csv and bash colors
#   than a real functional applicaton. It works but it's not
#   thoroughly tested.
# Usage:
#   Check help section for details.
# -------------------------------------------------------
# Script:

# Database file
datafile=todo_data/todo.csv

# Variables
DateCreated=`date +%d.%m.%Y.`
Id=""
Title=""
Description=""
Tags=""
EndDate="undefined"

## Colors
# Text colors
GrayText='\033[1;90m'
RedText='\033[1;31m'
GreenText='\033[1;32m'
BlueText='\033[1;34m'
EndColor='\e[0m'

# Background colors
RedBG='\e[101m'
GrayBG='\e[100m'
GreenBG='\e[42m'
BlueBG='\e[44m'

# Center text on the screen
# Used for heading
center() {
  case $1 in
    -[0-9]*) c_cols=${1#-}
    shift
    ;;
    *) c_cols=${COLUMNS:-150} ;;
  esac
  string="$*"
  c_len=$(( ( $c_cols - ${#string} ) / 2 + ${#string}))
  printf $GrayText
  printf "%${c_len}.${c_len}s" "$*"
  printf $EndColor
}

# Print some space
spacing(){
  printf "\n\n"
}

# Print a separator line
separator(){
  printf $GrayText
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' "-"
  printf $EndColor
}

# Write the data to csv file (append)
write_data(){
  echo "$DateCreated,$Title,$Description,$Tags,$EndDate" >> $datafile
}

# Read the data from the user input
# Status is inserted automaticaly but is not used
enter_data(){
  echo -e "$RedText Enter the name of the task and press [ENTER]: $EndColor"
  read Title
  echo -e "$RedText Describe the task and press [ENTER]: $EndColor"
  read Description
  echo -e "$RedText Enter the tags tags for the task one by one and press [ENTER]: $EndColor"
  echo -en "$RedText Example:$EndColor"
  echo -e "$GreenText tag1 tag2 tag3 tag4 $EndColor"
  read Tags
  echo -e "$RedText Enter a due date if there is one and press [ENTER] $EndColor"
  read EndDate
}

# Read the csv file
read_csv_file(){
  clear

  separator
  center TODO APPLICATION ; printf "\n"

  id=0
  INPUT=$datafile
  IFS=","
  [ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
  (cat $INPUT) | while read datecreated title description tags enddate
  do
    separator
    id=$(($id+1))

    echo -e "$GrayBG Id $EndColor : $RedBG $id $EndColor $GrayBG Date created $EndColor : $RedText $datecreated $EndColor\
 $GrayBG Title $EndColor : $GreenText $title $EndColor $GrayBG Tags $EndColor : $BlueText $tags $EndColor"

  done
  IFS=$OLDIFS

  spacing
}

select_one_line(){
  clear

  id=0
  INPUT=$datafile
  IFS=","
  [ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
  (cat $INPUT) | while read datecreated title description tags enddate
  do
    id=$(($id+1))
    if [ $id -eq "$1" ]; then
     printf "$GrayBG ID: %-8s $EndColor : $RedBG  $id $EndColor \n"
     printf "$GrayBG Date created $EndColor : $RedText $datecreated $EndColor \n"
     printf "$GrayBG Title %-6s $EndColor : $GreenText $title $EndColor \n"
     printf "$GrayBG EndDate %-4s $EndColor : $enddate  \n"
     printf "$GrayBG Description  $EndColor : $GreenText $description $EndColor \n"
     printf "$GrayBG Tags %-7s $EndColor : $BlueText $tags $EndColor \n"
    fi
  done
  IFS=$OLDIFS

  spacing
}

# Delete one csv file line using sed
delete_one_line(){
  sed -i "${1}d" $datafile
}

# Modify one line by using sed to insert a new line at the seleceted position and then
# removing the line after that
modify_one_line(){
  enter_data
  sed -i "${1}i $DateCreated,$Title,$Description,$Tags,$EndDate" $datafile
  delete_one_line $(($1+1))
}

# Testing some csv tools on the file
show_table_data(){
  csvcut -c 2,1,3,4,5  $datafile | csvlook
}

help(){
  echo " $0 - script for managing tasks"
  echo " $0 -n  -- add a new task"
  echo " $0 -a  -- list all tasks"
  echo " $0 -m1 -- update the task with id number 1"
  echo " $0 -d1 -- delete the task with id number 1"
  echo " $0 -c  -- show tasks using csvcut and csvlook"
}

main(){
while getopts 'acd:m:nt:h' flag; do
  case "${flag}" in
    a)
      read_csv_file
      ;;
    c)
      show_table_data
      ;;
    d)
      Id=${OPTARG}
      delete_one_line $Id
      ;;
    n)
      enter_data
      write_data
      ;;
    m)
      Id=${OPTARG}
      modify_one_line $Id
      ;;
    t)
      Id=${OPTARG}
      echo "Get task with id $Id"
      select_one_line $Id
      ;;
    h)
      help
      ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

}

main "$@"

exit 0
