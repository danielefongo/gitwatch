#!/bin/sh

update="N"

git fetch
lastRemote=""

while true; do

  git fetch
  UPSTREAM=${1:-'@{u}'}
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse "$UPSTREAM")
  BASE=$(git merge-base @ "$UPSTREAM")

  if [ $LOCAL != $REMOTE ] && [ $LOCAL = $BASE ]; then
    if [[ $lastRemote != "$REMOTE" ]]; then
      osascript -e 'display notification "Remote branch updated" with title "GitWatch Daemon"'
      lastRemote="$REMOTE"
      update="Y"
    fi
  else
    update="N"
  fi

  sleep 10
done
