#!/bin/bash

set -x

docker tag multi-petclinic:latest europe-west1-docker.pkg.dev/gd-gcp-internship-devops/docker-repo-mobrenovic/petclinic:v1
docker push europe-west1-docker.pkg.dev/gd-gcp-internship-devops/docker-repo-mobrenovic/petclinic:v1