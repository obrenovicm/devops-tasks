resource "google_compute_instance" "vm" {
  name = var.vm_name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.boot_disk.initialize_params.image
    }
  }

  network_interface {
    network = var.network_name
    subnetwork = var.subnetwork_name
    access_config {
      
    }
  }

  labels = {
    "ansible_target" = "true"
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_path)}"
  }
}