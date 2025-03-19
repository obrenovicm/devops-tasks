#!/bin/sh

set -eux

terraform init
terraform plan
terraform apply -auto-approve

ansible-playbook -i ../ansible/inventory.gcp.yml ../ansible/playbook.yml
