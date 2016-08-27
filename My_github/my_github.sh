#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	my_github.sh
# 	12.05.2016.-18:42:29
# -------------------------------------------------------
# Description:
#   Shortcut to my github account
# Usage:
#   Check help section
# -------------------------------------------------------
# Script:

# GitHub username
USER="miroslavvidovic"
# Url to the GitHub account for the $USER
URL="https://github.com/$USER/"

# Clone a repository to the current directory
clone_repository(){
  if [ -z "$repository" ]; then
    echo "ERROR: You need to enter the name of the repository you wish to clone."
  else
    git clone $URL$repository
  fi
}

# Get all the repositories for the user with curl and github api
all_my_repositories(){
  echo -e "All repositories for user $USER \n\n"
  curl -s "https://api.github.com/users/miroslavvidovic/repos" | grep -o 'git@[^"]*'
}

# Get all the repositoris for the user with curl and github api and filter only
# the repository name from the output with sed substitution
all_my_repositories_short_name(){
  echo -e "All repositories for user $USER \n\n"
  curl -s "https://api.github.com/users/miroslavvidovic/repos" | grep -o 'git@[^"]*' |\
    sed 's/git@github.com:miroslavvidovic\///g'
}

# my_github.sh with no input params triggers this error
check_for_empty_input(){
  if [ $# -eq 0 ];
  then
      echo -e "Error:  No input \n"
      help
      exit 1
    fi
}

help(){
  echo "Usage:
        $0 -a [show all the available repositories]
        $0 -i <repository_name> [clone a repository with the given name]"
}

main(){
  check_for_empty_input "$@"

  while getopts 'ac:h' flag; do
    case "${flag}" in
      a)
        all_my_repositories_short_name
          ;;
      c)
        repository=${OPTARG}
        clone_repository $repository
          ;;
      h) help
          ;;
    esac
  done
}

main "$@"

exit 0
