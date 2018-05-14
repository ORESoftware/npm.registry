#!/usr/bin/env bash


docker stop npmregistry;
docker rm npmregistry
docker build -t npmregistry .
docker run --net="host" -it --name npmregistry npmregistry

