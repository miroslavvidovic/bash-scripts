#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      extract-archives.sh
#   created:   13.04.2016.-12:34:31
#   revision:  12.01.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Requirements:
#   tar, unzip, uncompress, bunzip2, gunzip, 7z
# Description:
#   Script to extract most popular archive formats on linux.
# Usage:
#   extract_archives.sh file_to_extract.tar.bz2
# -----------------------------------------------------------------------------
# Script:

file=$1

extract(){
    if [ -f $file ] ; then
        case $file in
            *.tar.bz2)   tar xvjf $file     ;;
            *.tar.gz)    tar xvzf $file     ;;
            *.tar.xz)    tar xvjf $file     ;;
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
