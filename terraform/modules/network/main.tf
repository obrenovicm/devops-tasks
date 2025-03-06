resource "google_compute_network" "vpc" {
  name = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks

}

resource "google_compute_subnetwork" "subnetwork" {
  for_each = { for subnet in var.subnetworks : subnet.subnet_name => subnet}

  name = each.value.subnet_name
  network = google_compute_network.vpc.name
  region = each.value.region
  ip_cidr_range = each.value.ip_cidr_range
}