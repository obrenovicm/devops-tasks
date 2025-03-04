resource "google_compute_instance" "vm" {
  name = "mobrenovic-terraform-vm"
  machine_type = "e2-small"
  zone = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      
    }
  }

  metadata_startup_script = file("./modules/compute/startup.sh")

  network_interface {
    network = var.network_name
    subnetwork = var.subnetwork_name
    access_config {
      
    }
  }
}