#!/usr/bin/env bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	access_log.sh
# 	12.07.2016.-15:48:39
# -------------------------------------------------------
# Description:
#   Analyze apache server access log with some useful
#   information.
# Usage:
#   access_log.sh /path/to/access.log
# Dependencies:
#   scriptbc.sh
#   nicenumber.sh
# -------------------------------------------------------
# Script:

bytes_in_gb=1048576
scriptbc="./scriptbc.sh"
nicenumber="./nicenumber.sh"
host="intuitive.com"

if [ $# -eq 0 -o ! -f "$1" ] ; then
  echo "Usage: $(basename $0) logfile" >&2
  exit 1
fi

firstdate="$(head -1 "$1" | awk '{print $4}' | sed 's/\[//')"
lastdate="$(tail -1 "$1" | awk '{print $4}' | sed 's/\[//')"

echo "Results of analyzing log file $1"
echo ""
echo "  Start date: $(echo $firstdate|sed 's/:/ at /')"
echo "    End date: $(echo $lastdate|sed 's/:/ at /')"

hits="$(wc -l < "$1" | sed 's/[^[:digit:]]//g')"

echo "        Hits: $($nicenumber $hits) (total accesses)"

pages="$(grep -ivE '(.txt|.gif|.jpg|.png)' "$1" | wc -l | sed 's/[^[:digit:]]//g')"

echo "   Pageviews: $($nicenumber $pages) (hits minus graphics)"

totalbytes="$(awk '{sum+=$10} END {print sum}' "$1")"

echo -n " Transferred: $($nicenumber $totalbytes) bytes "

if [ $totalbytes -gt $bytes_in_gb ] ; then
  echo "($($scriptbc $totalbytes / $bytes_in_gb) GB)"
elif [ $totalbytes -gt 1024 ] ; then
  echo "($($scriptbc $totalbytes / 1024) MB)"
else
  echo ""
fi

# Scrape the log file for some useful data:

echo ""
echo "The ten most popular pages were:"

awk '{print $7}' "$1" | grep -ivE '(.gif|.jpg|.png)' | \
  sed 's/\/$//g' | sort | \
  uniq -c | sort -rn | head -10

echo ""

echo "The ten most common referrer URLs were:"

awk '{print $11}' "$1" | \
  grep -vE "(^"-"$|/www.$host|/$host)" | \
  sort | uniq -c | sort -rn | head -10

echo ""

exit 0
