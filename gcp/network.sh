#!/bin/bash

set -x

PROJECT=gd-gcp-internship-devops
NETWORK=mobrenovic-vpc
# VPC

gcloud compute networks create ${NETWORK} --project=${PROJECT} --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional --bgp-best-path-selection-mode=legacy

# subnet
gcloud compute networks subnets create subnet-a --project=${PROJECT} --range=10.0.1.0/24 --stack-type=IPV4_ONLY --network=${NETWORK} --region=europe-west1

# firewall
gcloud compute --project=${PROJECT} firewall-rules create obrenovicm-vpc-ssh-rule --direction=INGRESS --priority=1000 --network=${NETWORK} --action=ALLOW --rules=tcp:22 --source-ranges=0.0.0.0/0
gcloud compute --project=${PROJECT} firewall-rules create mobrenovic-vpc-custom-rule --direction=INGRESS --priority=1000 --network=${NETWORK} --action=ALLOW --rules=tcp:80,tcp:443,tcp:8080 --source-ranges=0.0.0.0/0