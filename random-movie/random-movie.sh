#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      random-movie.sh
#   created:   28.07.2017.-14:36:59
#   revision:
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   shuf - generate a random number
# Description:
#   Play a random movie from a directory. If you can't decide what to watch let
#   this script do it for you.
# Usage:
#   random-movie.sh
# -----------------------------------------------------------------------------
# Script:

# Directory containing your movie files
MOVIES_LOCATION=~/Desktop/Movies
# Favorite video player
PLAYER=vlc

main(){
  # Create a movie array with the result from find
  # find looks for all the files with the listed extensions
  # mkv, mp4, wmv, flv, webm, mov, avi
  declare -a movie_array
  readarray -t movie_array <<< "$( find "$MOVIES_LOCATION" -type f -name '*.mkv' -o -name '*.avi' -o -name '*.mp4' -o -name '*.wmv' -o -name '*.flv' -o -name '*.webm' -o -name '*.mov')"

  # Number of items in movie_array
  num_of_movies="${#movie_array[@]}"
  max_random=$((num_of_movies - 1))
  # Create a random number between 0 and max_random
  random_movie_num=$(shuf -i 0-$max_random -n 1)
  
  selected_file="${movie_array[$random_movie_num]}"

  while true; do
    echo "
    $(basename "$selected_file")

    (p) - play
    (r) - run random again
    (e) - exit"

    read -p "=> " command

    case "$command" in
      p )
        # Open the movie
        "$PLAYER" "$selected_file" 2>/dev/null 1>/dev/null &
        break
        ;;
      e)
        break
        ;;
      r)
        bash "$0"
        break
        ;;
    esac
  done
}

main "$@"

exit 0
