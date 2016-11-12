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
# Gruvbox theme
# Ctrl+Alt+o - search
# Ctrl+Alt+w - select window
rofi -key-run control+alt+o -key-window control+alt+w \
  -color-enabled true \
  -color-normal "#1d2021, #ebdbb2, #282828, #504945, #fabd2f" \
  -color-urgent "#cc241d, #1d2021, #cc241d, #fb4934, #1d2021" \
  -color-active "#d79921, #1d2021, #d79921, #fabd2f, #1d2021" \
  -color-window "#1d2021, #a89984, #a89984" \
  -separator-style  dash

exit 0
