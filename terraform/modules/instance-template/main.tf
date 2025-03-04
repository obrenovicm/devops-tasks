resource "google_compute_instance_template" "instance_template" {
  name = "mobrenovic-tf-template"
  machine_type = "e2-small"
  region = "europe-west1"
  project = var.project_id

  disk {
    source_image = var.image_link
    boot = true
  }

  network_interface {
    network = var.network_name
    subnetwork = var.subnetwork_name

    access_config {
      
    }
  }
}

resource "google_compute_instance_group_manager" "igm" {
  name = "mobrenovic-tf-igm"
  base_instance_name = "tf-misikori-instance"
  zone = "europe-west1-b"
  version {
    instance_template = google_compute_instance_template.instance_template.self_link_unique
  }

  project = var.project_id
  target_size = 3
}