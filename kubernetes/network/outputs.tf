output "network_id" {
  value = google_compute_network.custom.id
}

output "subnetwork_id" {
  value = { for k, v in google_compute_subnetwork.custom : k => v.id }
}

output "network_link" {
  value = google_compute_network.custom.self_link
}

output "subnetwork_link" {
  value = { for k, v in google_compute_subnetwork.custom: k => v.self_link}
}