#!/bin/bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	extract_archives.sh
# 	13.04.2016.-12:34:31
# -------------------------------------------------------
# Description:
#   Script to extract most popular archive formats on linux.
# Usage:
#   extract_archives.sh file_to_extract.tar.bz2
# -------------------------------------------------------
# Script:

file=$1

function extract()
{
    if [ -f $file ] ; then
        case $file in
            *.tar.bz2)   tar xvjf $file     ;;
            *.tar.gz)    tar xvzf $file     ;;
            *.bz2)       bunzip2 $file      ;;
            *.rar)       unrar x $file      ;;
            *.gz)        gunzip $file       ;;
            *.tar)       tar xvf $file      ;;
            *.tbz2)      tar xvjf $file     ;;
            *.tgz)       tar xvzf $file     ;;
            *.zip)       unzip $file        ;;
            *.Z)         uncompress $file   ;;
            *.7z)        7z x $file         ;;
            *)           echo "'$file' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$file' is not a valid file!"
    fi
}

main(){
  extract
}

main

exit 0
