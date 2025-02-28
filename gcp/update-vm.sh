#!/bin/bash

set -x 

gcloud compute instances add-metadata mobrenovic-instance --zone=europe-west1-b --metadata-from-file startup-script=startup-script.sh