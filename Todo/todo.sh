#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	todo.sh
# 	16.05.2016.-09:47:16
# -------------------------------------------------------
# Description:
#   Simple todo application with csv database and a colorful
#   output.
# Usage:
#   Check help section for details.
# -------------------------------------------------------
# Script:

# Database file
datafile="data/todo.csv"

# Variables
DateCreated=`date +%d.%m.%Y.`
Id=""
Title=""
Description=""
Tags=""
StartDate="undefined"
EndDate="undefined"
Status="active"

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
  echo "$DateCreated,$Title,$Description,$Tags,$StartDate,$EndDate,$Status" >> $datafile
}

# Read the data from the user input
enter_data(){
  echo -e "$RedText Enter the name of the task and press [ENTER]: $EndColor"
  read Title
  echo -e "$RedText Describe the task and press [ENTER]: $EndColor"
  read Description
  echo -e "$RedText Enter the tags tags for the task one by one and press [ENTER]: $EndColor"
  echo -en "$RedText Example:$EndColor"
  echo -e "$GreenText tag1 tag2 tag3 tag4 $EndColor"
  read Tags
}

# sed 1d - delete the first line of the file (csv header)
read_csv_file(){
  clear

  separator
  center TODO APPLICATION ; printf "\n"

  id=0
  INPUT=$datafile
  IFS=","
  [ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
  (cat $INPUT) | while read datecreated name description tags startdate enddate status
  do
    separator
    id=$(($id+1))

    echo -e "$GrayBG Id $EndColor : $RedBG $id $EndColor $GrayBG Date created $EndColor : $RedText $datecreated $EndColor\
 $GrayBG Title $EndColor : $GreenText $name $EndColor $GrayBG Tags $EndColor : $BlueText $tags $EndColor"

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
  (cat $INPUT) | while read datecreated name description tags startdate enddate status
  do
    id=$(($id+1))
    if [ $id -eq "$1" ]; then
     printf "$GrayBG ID: %-8s $EndColor : $RedBG  $id $EndColor \n"
     printf "$GrayBG Date created $EndColor : $datecreated \n"
     printf "$GrayBG Title %-7s $EndColor : $GreenBG $name $EndColor \n"
     printf "$GrayBG StartDate %-2s $EndColor : $startdate  \n"
     printf "$GrayBG EndDate %-4s $EndColor : $enddate  \n"
     printf "$GrayBG Description  $EndColor : $description \n"
     printf "$GrayBG Tags %-7s $EndColor : $BlueBG $tags $EndColor \n"
     printf "$GrayBG Status %-5s $EndColor : $BlueBG $status $EndColor \n"
    fi
  done
  IFS=$OLDIFS

  spacing
}

delete_one_line(){
  sed -i "${1}d" $datafile
}

modify_one_line(){
  enter_data
  sed -i "${1}i $DateCreated,$Title,$Description,$Tags,$StartDate,$EndDate,$Status" $datafile
  delete_one_line $(($1+1))
}

show_table_data(){
  csvcut -c 2,1,3,4,5  $datafile | csvlook
}

help(){
  echo "help"
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

main $@

exit 0
