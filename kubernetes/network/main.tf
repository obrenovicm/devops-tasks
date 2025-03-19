resource "google_compute_network" "custom" {
  name = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "custom" {
  for_each = { for subnet in var.subnetworks : subnet.subnet_name => subnet}

  name = each.value.subnet_name
  network = google_compute_network.custom.name
  region = each.value.region
  ip_cidr_range = each.value.ip_cidr_range
}