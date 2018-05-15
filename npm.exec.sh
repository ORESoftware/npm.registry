#!/usr/bin/env bash

  # make request to local server
  # local server responds with multiple files
  # for each file save them in the npm cache
  # the add the args below

  echo "running the npm override..";
  echo "running the npm patch" >&2;

  (
      set -e;

      rm -rf "$HOME/.npm-temp-cache";
      mkdir -p  "$HOME/.npm-temp-cache";
      cd  "$HOME/.npm-temp-cache"

#      nc localhost 3440 | tar -x > ores.tgz

      nc localhost 3440 | tar -x -O > ores-$(date +%s.%N).tgz


      for x in *; do
        command npm cache add "$x";
      done
  )

   exit_code="$?"

  if [[ "$exit_code" != "0" ]]; then
    echo "warning, we might not have been able to get new cache.";
  fi


  command npm "$@" --cache-min=99999 --prefer-offline
