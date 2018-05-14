#!/usr/bin/env bash


### RUN /bin/bash -c "source /usr/local/bin/virtualenvwrapper.sh"

if [[ "$npm.registry.override" != "yes" ]]; then
  echo "refusing to source npm.sh script because env is not set."
  exit 0;
fi


npm(){
  # make request to local server
  # local server responds with multiple files
  # for each file save them in the npm cache
  # the add the args below


  (
      set -e;

      rm -rf "$HOME/.npm-temp-cache";
      mkdir -p  "$HOME/.npm-temp-cache";
      cd  "$HOME/.npm-temp-cache"

      nc localhost 3440 | tar -x > ores.tgz

      for x in *; do
        command npm cache add "$x";
      done
  )

  local exit_code="$?"

  if [[ "$exit_code" != "0" ]]; then
    echo "warning, we might not have been able to get new cache.";
  fi


  command npm "$@" --cache-min=99999 --prefer-offline
}
