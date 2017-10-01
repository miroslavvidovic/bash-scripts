#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      my_composer.sh
#   created:   24.08.2016.-16:26:46
#   revision:  01.10.2017.
#   version:   1.1
# -----------------------------------------------------------------------------
# Requirements:
#   composer
# Description:
#   Wrapper script for composer. Run composer with xdebug ini disabled.
# Usage:
#   my_composer.sh some_composer_command
# Credit:
#   http://stackoverflow.com/questions/31083195/disabling-xdebug-when-running-composer
# -----------------------------------------------------------------------------
# Script:

php_no_xdebug() {
  local temporaryPath
  temporaryPath="$(mktemp -t php.XXXX).ini"

  # Using awk to ensure that files ending without newlines do not lead to configuration error
  php -i | grep "\.ini" | grep -o -e '\(/[a-z0-9._-]\+\)\+\.ini' | grep -v xdebug | xargs awk 'FNR==1{print ""}1' > "$temporaryPath"

  php -n -c "$temporaryPath" "$@"
  rm -f "$temporaryPath"
}

php_no_xdebug /usr/bin/composer "$@"

exit 0
