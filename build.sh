#!/usr/bin/env bash

# run docker build
echo "[*] Building docker container"
docker build -t chrisawcom/buildtwrp .

# create out directory
mkdir -p out/

# docker run
echo "[*] Starting TWRP build"
docker run --privileged --tty --rm -v "$(pwd):/var/tmp/buildtwrp" chrisawcom/buildtwrp
