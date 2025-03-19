resource "google_container_cluster" "cluster" {
  name = var.cluster_name
  location = var.location
  initial_node_count = var.workers_count
  deletion_protection = false
  network = var.network
  subnetwork = var.subnetwork
}