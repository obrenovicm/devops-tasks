#!/bin/bash

set -x

# create a vm instance
PROJECT=gd-gcp-internship-devops
NETWORK=mobrenovic-vpc

gcloud compute instances create mobrenovic-instance --project=${PROJECT} --zone=europe-west1-b --machine-type=e2-small --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,network=${NETWORK},subnet=subnet-a --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=71936227901-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --create-disk=auto-delete=yes,boot=yes,device-name=mobrenovic-instance,image=projects/debian-cloud/global/images/debian-12-bookworm-v20250212,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

