#!/bin/sh

# build and start the app container

dotnet publish -c Release -r debian.10-x64 src/prometheus-net-example/prometheus-net-example.fsproj
docker build -t prometheus-net-example .
# if you want to run `perf` add `--cap-add SYS_ADMIN` to this command line after `run`
# if you want to jump into the container shell add `/bin/bash` to the end
docker run  -v "$(pwd)/output":/output --rm -it -p=5000:80 --name prom-test prometheus-net-example