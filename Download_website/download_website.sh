#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	download_website.sh
#  	01.09.2016.-17:22:46
# -----------------------------------------------------------------------------
# Description:
#   Download a webpage.
# Usage:
#   Run
#   download_website.sh
#   and enter the url in the form.
# -----------------------------------------------------------------------------
# Script:

# Dowload website using wget
# @param $1 - Url of the website
download(){
  wget -E -H -k -K -p "$1"
}

main(){
  # Regex for url check
  regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

  url=$(dialog --inputbox "Enter the URL of the website you wish to download. \
    Valid link example: http://miroslavvidovic.github.io" 10 50  --output-fd 1)

  clear

  # Check url with regex
  if [[ $url =~ $regex ]]
  then
      echo "Link valid"
      download "$url"
  else
      echo "Link not valid"
      exit 1
  fi
}

main "$@"
exit 0
