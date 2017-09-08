#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      mybitbucket.sh
#   created:   15.06.2016.-08:52:01
#   revision:  08.09.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Requirements:
#
# Description:
#
# Usage:
#   mybitbucket.sh
#
# -----------------------------------------------------------------------------
# Script:
SCRIPTNAME=$(basename "$0")

# Bitbucket username
USER="vidovicmiroslav"
# Bitbucket account URL
URL="https://bitbucket.org/$USER/"

check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      echo -e "Error:  No input \n"
      help_message
      exit 1
    fi
}

clone_repository(){
  if [ -z "$repository" ]; then
    echo "ERROR: You need to enter the name of the repository you wish to clone."
  else
    git clone "$URL$repository"
  fi
}

# Lists only public repositories
all_public_repositories(){
  data=$(curl -s "https://api.bitbucket.org/2.0/repositories/vidovicmiroslav"|\
    jq '.values[] | "\(.name)"')

  echo "$data"
}

help_message(){
  echo "$SCRIPTNAME usage:
        -a                      Show all public repositories
        -c [repository_name]    Clone a repository
        "
}

main(){
  check_for_empty_input "$@"

  while getopts 'ac:h' flag; do
    case "${flag}" in
      a)
        all_public_repositories
          ;;
      c)
        repository=${OPTARG}
        clone_repository "$repository"
          ;;
      h) help_message
          ;;
    esac
  done
  shift $((OPTIND-1))
}


main "$@"

exit 0
