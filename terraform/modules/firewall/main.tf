resource "google_compute_firewall" "firewall" {
  name = "custom-firewall"
  project = var.project_id
  network = var.network_name
  direction = "INGRESS"
  source_ranges = [ "0.0.0.0/0" ]
  
  allow {
    protocol = "tcp"
    ports = [ "22", "8080" ]
  }
}

resource "google_compute_firewall" "hc-firewall" {
  name = "xlb-fw-allow-hc"
  direction = "INGRESS"
  network = var.network_name
  priority = 1000
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags = ["allow-health-check"]
  allow {
    ports = [ "80" ]
    protocol = "tcp"
  }
}