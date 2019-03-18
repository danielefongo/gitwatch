#!/bin/sh

update="N"

while true; do

  git fetch
  UPSTREAM=${1:-'@{u}'}
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse "$UPSTREAM")
  BASE=$(git merge-base @ "$UPSTREAM")

  if [ $LOCAL = $REMOTE ]; then
    update="N"
  elif [ $LOCAL = $BASE ]; then
    if [[ $update = "N" ]]; then
      osascript -e 'display notification "Remote branch updated" with title "GitWatch Daemon"'
      update="Y"
    fi
  else
    update="N"
  fi

  sleep 10
done
