#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      merge-pdf.sh
#   created:   06.02.2017.-17:55:25
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements: 
#   gs(ghostscript)
#
# Description:
#   Merge multiple pdf files into one file.
# 
# Usage:
#   bash merge-pdf.sh file1.sh file2.sh file3.sh file4.sh 
# -----------------------------------------------------------------------------
# Script:

checking(){
  echo ""  
}

merge(){
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE\
     -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 \
     -sOutputFile=output.pdf "$@"
}

main(){
  merge "$@"
}

main "$@"

exit 0
