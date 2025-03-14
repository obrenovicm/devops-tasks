#!/bin/sh

set -eux

terraform init
terraform plan
terraform apply -auto-approve

ansible-playbook -i ../ansible/inventory.gcp.yml --private-key="~/.ssh/ansible_ed25519" ../ansible/playbook.yml
