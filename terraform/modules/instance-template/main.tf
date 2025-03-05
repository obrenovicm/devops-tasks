resource "google_compute_instance_template" "instance_template" {
  name = "mobrenovic-tf-template"
  machine_type = "e2-small"
  region = "europe-west1"
  project = var.project_id

  disk {
    source_image = var.image_link
    boot = true
  }

  metadata = {
    startup-script = "#! /bin/bash\n vm_hostname=\"$(curl -H \"Metadata-Flavor:Google\" \\\n   http://169.254.169.254/computeMetadata/v1/instance/name)\"\n   sudo echo \"Page served from: $vm_hostname\" | \\\n   tee /var/www/html/index.html\n   sudo systemctl restart apache2"
  }

  network_interface {
    network = var.network_name
    subnetwork = var.subnetwork_name

    access_config {
      
    }
  }

  tags = ["allow-health-check"]
}

resource "google_compute_instance_group_manager" "igm" {
  name = "mobrenovic-tf-igm"
  base_instance_name = "tf-misikori-instance"
  zone = "europe-west1-b"
  version {
    instance_template = google_compute_instance_template.instance_template.self_link_unique
    name = "primary"
  }

  named_port {
    name = "http"
    port = 80
  }

  project = var.project_id
  target_size = 3
}