#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      chuck-norris.sh
#   created:   29.08.2017.-15:32:45
#   revision:
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   cowsay
# Description:
#   Get a random joke from the https://api.chucknorris.io/ API
# -----------------------------------------------------------------------------
# Script:

spinner() {
  local pid=$1
  local delay=0.75
  local spinstr='|/-\'
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
      local temp=${spinstr#?}
      printf " [%c]  " "$spinstr"
      local spinstr=$temp${spinstr%"$temp"}
      sleep $delay
      printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

# param $1 - json data
# param $2 - value that needs to be extracted
# example:
# parse_json '{"username":"donald, trump","password":"mexicanwa11"}' username
# returns: donald, trump
parse_json() {
    echo $1 | \
    sed -e 's/[{}]/''/g' | \
    sed -e 's/", "/'\",\"'/g' | \
    sed -e 's/" ,"/'\",\"'/g' | \
    sed -e 's/" , "/'\",\"'/g' | \
    sed -e 's/","/'\"---SEPERATOR---\"'/g' | \
    awk -F=':' -v RS='---SEPERATOR---' "\$1~/\"$2\"/ {print}" | \
    sed -e "s/\"$2\"://" | \
    tr -d "\n\t" | \
    sed -e 's/\\"/"/g' | \
    sed -e 's/\\\\/\\/g' | \
    sed -e 's/^[ \t]*//g' | \
    sed -e 's/^"//'  -e 's/"$//'
}

(data=$(curl -s --request GET \
       --url 'https://api.chucknorris.io/jokes/random' \
       --header 'accept: (application/json|text/plain)')

printf "\n\n"
cowsay $(printf "$(parse_json "$data" value)")
) &

spinner $!

exit 0
