output "network_name" {
  description = "The name of created VPC"
  value = google_compute_network.vpc.name
}

output "subnets_names" {
  description = "The names of created subnets"
  value = [ for subnet in google_compute_subnetwork.subnetwork : subnet.name]
}

output "subnet_ips" {
  description = "The IP and CIDRs of the created subnets"
  value = [ for subnet in google_compute_subnetwork.subnetwork : subnet.ip_cidr_range]
}

output "subnets_regions" {
  description = "The region where subnets will be created"
  value = [ for subnet in google_compute_subnetwork.subnetwork : subnet.region]
}