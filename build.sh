#!/bin/sh

# build and start the app container

dotnet publish -c Release -r debian.10-x64 src/prometheus-net-example/prometheus-net-example.fsproj
docker build -t prometheus-net-example .
docker run --privileged --rm -it -p=5000:80 --name prom-test prometheus-net-example