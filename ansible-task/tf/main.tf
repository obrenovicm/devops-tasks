module "vpc" {
  source = "./modules/network"
  network_name = var.network_name
  subnetworks = var.subnets
}

module "vms" {
  source = "./modules/compute"
  network_name = module.vpc.network_name
  subnetwork_name = module.vpc.subnets_names[0]
  vm_name = var.vm_name
  ssh_pub_key_path = var.ssh_pub_key_path
  ssh_user = var.ssh_user
}

module "firewall" {
  source = "./modules/firewall"
  network = module.vpc.network_name
  firewall_rules = var.firewall_rules
}

module "ans" {
  source = "./modules/ans"
  ansible_host_name = var.ansible_host_name
  ansible_host_ip = module.vms.external-ip
  ansible_user = var.ssh_user
  ssh_private_key = file(var.ssh_private_key_path)
  depends_on = [ module.vms ]
}