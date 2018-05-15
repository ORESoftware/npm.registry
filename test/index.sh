#!/usr/bin/env bash


#foo="$(netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}')"
#
#echo "the foo is: $foo";

#source "./npm.sh" && npm install --loglevel=warn

npm cache clear -f;
npm cache clean -f;

rm -rf "$HOME/.npm";
mkdir -p "$HOME/.npm";

npm set registry "http://npm_registry_server:3441"
npm config set registry "http://npm_registry_server:3441"

npm install --loglevel=warn
