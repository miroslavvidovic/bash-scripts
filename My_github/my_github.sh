#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      my_github.sh
#   created:   12.05.2016.-18:42:29
#   revision:  04.04.2017.
#   version:   2.0
# -----------------------------------------------------------------------------
# Requirements:
#   git, jq
# Description:
#   Manage your GitHub repositories using bash and GitHub API.
# Usage:
#   my_github.sh
# -----------------------------------------------------------------------------
SCRIPTNAME=$(basename "$0")

# Script:

# GitHub username
USER="miroslavvidovic"

# GitHub account URL
URL="https://github.com/$USER/"

# Clone a repository to the current directory
clone_repository(){
  if [ -z "$repository" ]; then
    echo "ERROR: You need to enter the name of the repository you wish to clone."
  else
    git clone "$URL$repository"
  fi
}

# Get all the public repositories for the user with curl and github api and filter only
# the repository name from the output with sed substitution
public_repositories(){
  echo -e "Public repositories for $USER \n\n"
  curl -s "https://api.github.com/users/$USER/repos?per_page=1000" | grep -o 'git@[^"]*' |\
    sed "s/git@github.com:$USER\///g"
}

starred_repositories(){
  echo -e "Repositories starred by $USER \n\n"
  curl -s "https://api.github.com/users/$USER/starred?per_page=1000" | jq -r '.[] | .html_url +" => "+ .description'
}

gists(){
  echo -e "Public gists by $USER \n\n"
  curl -s "https://api.github.com/users/$USER/gists?per_page=1000" | jq -r '.[] | .html_url +" => "+ .description'
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
  echo "$SCRIPTNAME usage:
          -a                        Show all the available repositories
          -c [repository_name]      Clone a repository with the given name
          -s                        Show all starred repositories
          -g                        Show all gists"
}

main(){
  check_for_empty_input "$@"

  while getopts 'ac:ghs' flag; do
    case "${flag}" in
      a)
        public_repositories
          ;;
      c)
        repository=${OPTARG}
        clone_repository "$repository"
          ;;
      g)
        gists
          ;;
      s)
        starred_repositories
          ;;
      h) help
          ;;
    esac
  done
  shift $((OPTIND-1))
}

main "$@"

exit 0
