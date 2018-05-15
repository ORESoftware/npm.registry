#!/usr/bin/env bash


#foo="$(netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}')"
#
#echo "the foo is: $foo";

source "./npm.sh" && npm install --loglevel=warn
