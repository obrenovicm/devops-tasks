module "vpc" {
  source     = "./modules/network"
  project_id = var.project_id

}

module "vm" {
  source       = "./modules/compute"
  network_name = module.vpc.network_name
  subnetwork_name = module.vpc.subnets_names[0]
}

module "firewall" {
  source = "./modules/firewall"
  network_name = module.vpc.network_name
  project_id = var.project_id
}

module "instance_template" {
  source = "./modules/instance-template"
  network_name = module.vpc.network_name
  subnetwork_name = module.vpc.subnets_names[0]
  image_link = module.vm.image_link
  project_id = var.project_id

}

