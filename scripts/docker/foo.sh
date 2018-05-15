#!/usr/bin/env bash

set -e;

docker stop npm_registry
docker rm npm_registry
docker build -t npm_registry .
docker run --net="host" -it --name npm_registry npm_registry

