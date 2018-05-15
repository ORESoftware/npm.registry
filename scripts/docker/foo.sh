#!/usr/bin/env bash

set -e;

#docker network rm foo || echo "no network";
docker network create "foo" || echo "network already exists??"

docker stop npm_registry_server || echo "no container to stop."
docker rm npm_registry_server  || echo "no container to remove."


docker build -t npm_registry_server -f Dockerfile.server .

#docker run -v /var/run/docker.sock:/var/run/docker.sock -it --name npm_registry npm_registry
docker run -d --net="foo" -it --name npm_registry_server npm_registry_server


docker stop npm_registry || echo "no container to stop."
docker rm npm_registry  || echo "no container to remove."
docker build -t npm_registry .

#docker run -v /var/run/docker.sock:/var/run/docker.sock -it --name npm_registry npm_registry
docker run --net="foo" -it --name npm_registry npm_registry

