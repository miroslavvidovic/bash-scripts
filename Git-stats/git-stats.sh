#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      git-stats.sh
#   created:   27.06.2017.-15:59:31
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   xdg-open, gitinspector, gitstats, git
# Description:
#   Generate git statistics for a repository using gitinspector and gitstats tools
# Usage:
#   git-stats.sh repository-location output-destination
# -----------------------------------------------------------------------------
# Script:

# Check the required dependencies for the script to work properly
check_dependecies(){
  dependencies=(gitstats gitinspector xdg-open)

  for i in "${dependencies[@]}"; do
    if ! hash "$i" 2>/dev/null; then
      echo "Error: You should install $i for the script to work" 
    fi
  done
}

# Simple home page that will be opend after the script finishes
generate_home_page(){
  cat << _EOF_
  <!DOCTYPE html>
  <html>
  <head>
  <meta charset="UTF-8">
  <title>Title of the document</title>
  </head>

  <body>
  <div align="center">
  <h4>Statistics for "$1" <h4>
  <a href="gitstats/index.html" style="text-decoration:none">
     <input type="button" value="gitstats" />
  </a>
  <a href="gitinspector.html" style="text-decoration:none">
     <input type="button" value="gitinspector" />
  </a>
  <div>
  </body>

  </html> 
_EOF_
}

help(){
cat<< EOF
usage: $(basename "$0") <repository dir> <output dir> 

EOF
  exit
}

# Check for 2 input variables
check_input(){
  if [ "$#" -ne 2 ] ;then
    echo -e "Invalid command\n"
    help
    exit 0
  fi
}

main(){
  check_dependecies

  check_input "$@"

  repository="$1"
  # Check if the variable is a git repository
  git -C "$repository" rev-parse
  if [[ "$?" -ne 0 ]]; then
    help
    exit 0
  fi

  output="$2"

  gitstats "$repository" "$output"/git-stats/gitstats
  gitinspector -T -l -m -r --format=html --file-types=** "$repository" > "$output"/git-stats/gitinspector.html
  generate_home_page "$repository" > "$output"/git-stats/index.html

  xdg-open "$output"/git-stats/index.html
}

main "$@"

exit 0
