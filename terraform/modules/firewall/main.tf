resource "google_compute_firewall" "firewall" {
  name = "custom-firewall"
  project = var.project_id
  network = var.network_name

  source_ranges = [ "0.0.0.0/0" ]
  
  allow {
    protocol = "tcp"
    ports = [ "22", "80", "8080" ]
  }
}