output "xlb-static-ip" {
  value = google_compute_global_address.lb-external-addr.address
}