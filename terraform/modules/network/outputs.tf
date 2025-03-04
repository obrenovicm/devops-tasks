output "network_name" {
  description = "The name of created VPC"
  value = module.test-vpc.network_name
}

output "subnets_names" {
  description = "The names of created subnets"
  value = module.test-vpc.subnets_names
}

output "subnet_ips" {
  description = "The IP and CIDRs of the created subnets"
  value = module.test-vpc.subnets_ips
}

output "subnets_regions" {
  description = "The region where subnets will be created"
  value = module.test-vpc.subnets_regions
}