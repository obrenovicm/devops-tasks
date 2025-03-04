resource "google_compute_instance" "vm" {
  name = "mobrenovic-terraform-vm"
  machine_type = "e2-small"
  zone = "europe-west1-b"

  boot_disk {
    auto_delete = false
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

resource "google_compute_snapshot" "snapshot" {
  name = "mobrenovic-tf-snapshot"
  source_disk = google_compute_instance.vm.boot_disk[0].source
  zone = google_compute_instance.vm.zone
}

resource "google_compute_image" "custom-img" {
  name = "mobrenovic-tf-image"
  source_snapshot = google_compute_snapshot.snapshot.self_link
}