#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      random-variable.sh
#   created:   15.08.2017.-19:50:38
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
# 
# Description:
#   No more foo and bar. Generate random variable names from a list of English 
#   words.
# Usage:
# 
# -----------------------------------------------------------------------------
# Script:

# File containing the words
# Wordfile can be dict location on linux => /usr/share/dict
# this assumes that the file is in the same location as the script
WORDFILE=$(dirname $0)/words.txt

get_word() {
  local word

  # Get a random word from the wordfile
  word=$(shuf -n1 "$WORDFILE")

  # Remove all non alphabet chars
  word=$(echo "$word" | sed 's/[^a-zA-Z0-9]//g')

  # To lowercase
  word=${word,,}

  echo "$word"
}

main() {
  word1=$(get_word)
  word2=$(get_word)

  while getopts 'nscl' flag; do
    case "${flag}" in
      n)
        echo "$word1"
          ;;
      c)
        word2="${word2^}"
        echo "$word1$word2"
          ;;
      l)
      echo "$word1""-""$word2"
          ;;
      s)
      echo "$word1""_""$word2"
          ;;
      h) help
          ;;
    esac
  done
  shift $((OPTIND-1))
}

main "$@"

exit 0
