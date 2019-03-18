#!/bin/sh

update="N"

while true; do
  git fetch
  if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
    if [[ $update = "N" ]]; then
      osascript -e 'display notification "Remote branch updated" with title "GitWatch Daemon"'
      update="Y"
    fi
  else
    update="N"
  fi

  sleep 10
done
