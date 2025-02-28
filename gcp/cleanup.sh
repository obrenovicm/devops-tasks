#!/bin/bash

set -x

PROJECT=gd-gcp-internship-devops
NETWORK=mobrenovic-vpc

# vm
gcloud compute instances delete mobrenovic-instance --project=${PROJECT} --zone=europe-west1-b

# firewall
gcloud compute --project=${PROJECT} firewall-rules delete obrenovicm-vpc-ssh-rule
gcloud compute --project=${PROJECT} firewall-rules delete mobrenovic-vpc-custom-rule 

# gar
gcloud artifacts repositories delete docker-repo-mobrenovic 

# subnet
gcloud compute networks subnets delete subnet-a --project=${PROJECT} --zone=europe-west1-b

# vpc
gcloud compute networks delete ${NETWORK} --project=${PROJECT} 