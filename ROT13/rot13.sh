#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	rot13.sh
# 	26.07.2016.-12:52:13
# -------------------------------------------------------
# Description:
#   ROT13 cipher is a variation of Ceasear cipher
# Usage:
#
# -------------------------------------------------------
# Script:


## Ranges of characters are used; [a-m] expands to abcdefghijklm
## and will be replaced by the corresponding character in the range [n-z]
## Each letter in the first half of the alphabet is replaced by
## a letter from the second half, and vice versa.
rot_13(){
  echo $input | tr '[a-m][A-M][n-z][N-Z]' '[n-z][N-Z][a-m][A-M]'
}

main(){
  input="$@"
  rot_13
}

main "$@"

exit 0
