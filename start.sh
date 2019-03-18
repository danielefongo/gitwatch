#!/bin/sh

gitwatch_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
pid_file="$gitwatch_dir/pid"

function __gitwatch_start() {
  if [[ -f "$pid_file" ]]; then
    echo "GitWatch already started. Aborting."
    return
  fi

  bash "$gitwatch_dir/check.sh" >/dev/null 2>&1 < /dev/null &
  echo $! > "$pid_file"
  echo "GitWatch Daemon started."
}

function __gitwatch_stop() {
  if [[ -f "$pid_file" ]]; then
    PID=`cat $pid_file`
    echo "Stopping GitWatch Daemon."
    kill $PID
    rm -rf "$pid_file"
  fi
}

function gitwatch() {
  subcommand=$1
    shift
    valid_command=`declare -f __gitwatch_$subcommand`
    if [[ $valid_command ]]; then
        __gitwatch_$subcommand $@
    else
        echo -e "Invalid subcommand. Possible commands: start, stop"
    fi
}