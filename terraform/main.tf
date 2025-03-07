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

module "xlb" {
  source = "./modules/lb"
  instance_group = module.instance_template.instance_group

  static-name = var.static-name
  hc-name = var.hc-name
  http_health_check = var.http_health_check
  backend-service-name = var.backend-service-name
  backend-port-name = var.backend-port-name
  url-map-name = var.url-map-name
  proxy-name = var.proxy-name
  forwarding-rule-name = var.forwarding-rule-name
  ip-protocol = var.ip-protocol
  port-range = var.port-range
}