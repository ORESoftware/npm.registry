#!/usr/bin/env bash


docker stop ts-project;
docker rm ts-project
docker build -t ts-project .
docker run --net="host" -it --name ts-project ts-project
