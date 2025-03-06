module "vpc" {
  source     = "./modules/network"
  network_name = var.vpc_name
  subnetworks = var.subnets

}

module "vm" {
  source       = "./modules/compute"
  network_name = module.vpc.network_name
  subnetwork_name = module.vpc.subnets_names[0]
  vm_name = var.vm_name

}

module "firewall" {
  source = "./modules/firewall"
  network = module.vpc.network_name
  firewall_rules = var.firewall_rules
}

module "instance_template" {
  source = "./modules/instance-template"
  network_name = module.vpc.network_name
  subnetwork_name = module.vpc.subnets_names[0]
  image_link = module.vm.image_link
  template_name = var.template_name

  group-name = var.group-name
  base_instance_name = var.base_instance_name
  tags = var.tags
  target_size = var.target_size
  named_port = var.named_port
}

# module "xlb" {
#   source = "./modules/lb"
#   instance_group = module.instance_template.instance_group
# }