#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	githubuser.sh
# 	20.12.2016.-17:18:33
# -----------------------------------------------------------------------------
# Description:
#   Given a GitHub username, pulls information about the user usin the GitHub
#   API.
# Usage:
#   githubuser.sh username
# -----------------------------------------------------------------------------
# Script:

if [ $# -ne 1 ]; then
  echo "Usage: $0 <username>"
  exit 1
fi

curl -s "https://api.github.com/users/$1" | \
  awk -F'"' '
    /\"name\":/ {
    print $4" is the name of the GitHub user."
    }
    /\"location\":/{
    print $4" is the users location."
    }
    /\"bio\":/{
    print $4" is written in the users bio."
    }
    /\"followers\":/{
    split($3, a, " ")
    sub(/,/, "", a[2])
    print "The user has "a[2]" followers."
    }
    /\"following\":/{
    split($3, a, " ")
    sub(/,/, "", a[2])
    print "The user is following "a[2]" other users."
    }
    /\"public_repos\":/{
    split($3, a, " ")
    sub(/,/, "", a[2])
    print "The user has "a[2]" public repositories."
    }
    /\"public_gists\":/{
    split($3, a, " ")
    sub(/,/, "", a[2])
    print "The user has "a[2]" public gists."
    }
    /\"created_at\":/{
    print "The account was created on "$4"."
    }
  '
exit 0
