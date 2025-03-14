terraform {
  required_providers {
    ansible = {
      source = "ansible/ansible"
      version = "1.3.0"
    }
  }
}

resource "ansible_host" "host" {
  name = var.ansible_host_name
  groups = [ "docker" ]
  variables = {
    ansible_host = var.ansible_host_ip
    ansible_user = var.ansible_user
    ansible_ssh_private_key_file = var.ssh_private_key
  }
}

# resource "ansible_playbook" "playbook" {
#   name = ansible_host.host.name
#   playbook = var.playbook
#   depends_on = [ ansible_host.host ]
# }