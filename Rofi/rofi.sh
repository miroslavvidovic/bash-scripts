#/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	rofi.sh
# 	12.10.2016.-09:43:45
# -----------------------------------------------------------------------------
# Description:
#   Startup settings for rofi. When started rofi runs in a daemon and the
#   specified keybindings can trigger window or run actions.
# Usage:
#   Run the script or alias rofi to this script or even better add the script to
#   startup applications.
# -----------------------------------------------------------------------------
# Script:

# ROFI Color theme and keybindings
# Violet theme from the website (looks good on Ubuntu)
# Ctrl+Alt+o - search
# Ctrl+Alt+w - select window
rofi -key-run control+alt+o -key-window control+alt+w \
  -color-enabled true \
  -color-normal "argb:a02f1e2e, #b4b4b4, argb:a02f1e2e, argb:54815ba4, #ffffff" \
  -color-urgent "argb:272f1e2e, #ef6155, argb:2f2f1e2e, argb:54815ba4, #ef6155" \
  -color-active "argb:272f1e2e, #815ba4, argb:2f2f1e2e, argb:54815ba4, #815ba4" \
  -color-window "#2f1e2e, argb:36ef6155, argb:2fef6155" \
  -separator-style  dash

exit 0
