#!/bin/bash

set -x

PROJECT=gd-gcp-internship-devops
gcloud artifacts repositories create docker-repo-mobrenovic --repository-format=docker --location=europe-west1 --description="Docker repository" --project=${PROJECT}