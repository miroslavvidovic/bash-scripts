#!/bin/bash

# -------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	eclipseman.sh
# 	26.04.2016.-20:12:12
# -------------------------------------------------------
# Description:
#   Start different versions of eclipse via terminal.
# Usage:
#   eclipseman.sh java
# -------------------------------------------------------
# Script:

# Export any settings needed to run eclipse on ubuntu
# fix broken menu
export UBUNTU_MENUPROXY=0

OPTION=$1

# Path to eclipse
# in subdirs inside this directory are eclipse variations
ECLIPSEPATH=$HOME/Eclipse

# Eclipse versions (subdirectory names)
eclipseJava=eclipse-java
eclipseJavaEE=eclipse-jee
eclipseModeling=eclipse-modeling
eclipseTesting=eclipse-testing
eclipseScala=eclipse-scala

# Start the eclipse editor
# param $1 - subdirectory inside the $ECLIPSEPATH directory
start_eclipse(){
  $ECLIPSEPATH/$1/eclipse
}

# Help function
helper(){
  echo "
    Available options:

    $0
        java     - start eclipse for Java
        ee       - start eclipse for JavaEE
        modeling - start eclipse for Modeling
        testing  - start eclipse for Testing
        scala    - start eclipse for Scala

  "
}

case "$OPTION" in
  java)
       echo "java"
       start_eclipse $eclipseJava
    ;;
  ee)
       echo "javaee"
       start_eclipse $eclipseJavaEE
    ;;
  modeling)
       echo "modeling"
       start_eclipse $eclipseModeling
    ;;
  testing)
       echo "testing"
       start_eclipse $eclipseTesting
    ;;
  scala)
      echo "scala"
      start_eclipse $eclipseScala
    ;;
  help) echo "help"
        helper
    ;;
  *) echo "Not a valid option."
      helper
    ;;
  esac

exit 0
