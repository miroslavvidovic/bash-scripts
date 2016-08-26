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

input=$1
repository=$1

user="miroslavvidovic"
url="https://github.com/$user/"

clone_repository(){
  if [ -z "$repository" ]; then
    echo "ERROR: You need to enter the name of the repository you wish to clone."
  else
    git clone $url$repository
  fi
}

all_my_repositories(){
  curl -s "https://api.github.com/users/miroslavvidovic/repos" | grep -o 'git@[^"]*'
}

all_my_repositories_filtered(){
  curl -s "https://api.github.com/users/miroslavvidovic/repos" | grep -o 'git@[^"]*' | sed 's/github.com:miroslavvidovic//g' | sed 's/git//g' | sed 's/@//g' | tr -d '/'
}

help(){
  echo "Usage: $0
        showall [show all the available repositories]
        <string> [clone a repository with the given name]"
}

#TODO convert ot optargs
main(){
  case "$input" in

    help) echo "Help"
          echo ""
          help
      ;;
    showall) echo "All repositories for user $user"
             echo ""
          all_my_repositories
      ;;
    *) echo "Cloning repository $repository"
       echo ""
      clone_repository $repository
      ;;
    esac
}


main

exit 0
