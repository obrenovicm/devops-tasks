resource "google_compute_instance" "vm" {
  name = var.vm_name
  machine_type = var.machine_type

  boot_disk {
    auto_delete = var.boot_disk.auto_delete
    initialize_params {
      image = var.boot_disk.initialize_params.image
    }
  }

  metadata_startup_script = file(var.metadata_startup_script)

  network_interface {
    network = var.network_name
    subnetwork = var.subnetwork_name
    access_config {
      
    }
  }
}

resource "google_compute_snapshot" "snapshot" {
  name = "${google_compute_instance.vm.name}-snapshot"
  source_disk = google_compute_instance.vm.boot_disk[0].source
  zone = google_compute_instance.vm.zone
}

resource "google_compute_image" "custom-img" {
  name = "${google_compute_instance.vm.name}-image"
  source_snapshot = google_compute_snapshot.snapshot.self_link
}