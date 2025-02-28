#!/bin/bash

set -x

sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo docker pull obrenovicm/main:f79d15bb