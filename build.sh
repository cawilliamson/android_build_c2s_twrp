#!/usr/bin/env bash

# run docker build
docker build -t chrisawcom/buildtwrp .

# create out directory
mkdir -p out/

# docker run
docker run --privileged --tty --rm -v "$(pwd):/var/tmp/buildtwrp" chrisawcom/buildtwrp
