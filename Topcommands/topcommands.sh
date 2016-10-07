# -----------------------------------------------------------------------------
# Info:
# 	Miroslav Vidovic
# 	topcommands.sh
# 	07.10.2016.-08:55:57
# -----------------------------------------------------------------------------
# Description:
#   Show top used commands from the history file.
# Usage:
#   topcommands.sh 10
# -----------------------------------------------------------------------------
# Script:

history_top(){
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n$1
}

main(){
  # Number of commands from the input
  cmd_number=$1

  if [[ -z $cmd_number ]]; then
    echo "Provide a number for the top used commands."
    exit 1
  fi

  echo -e "Top $cmd_number commands \n"
  history_top $cmd_number
}

main "$@"

exit 0
