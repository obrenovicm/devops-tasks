resource "google_compute_instance_template" "instance_template" {
  name = var.template_name
  machine_type = var.machine_type

  disk {
    source_image = var.image_link
    boot = true
  }

  metadata = {
    startup-script = "#! /bin/bash\n vm_hostname=\"$(curl -H \"Metadata-Flavor:Google\" \\\n   http://169.254.169.254/computeMetadata/v1/instance/name)\"\n   sudo echo \"Page served from: $vm_hostname\" | \\\n   tee /var/www/html/index.html\n   sudo systemctl restart apache2"
  } # TODO here.

  network_interface {
    network = var.network_name
    subnetwork = var.subnetwork_name

   
  }

  tags = var.tags
}

resource "google_compute_instance_group_manager" "igm" {
  name = var.group-name
  base_instance_name = var.base_instance_name
  version {
    instance_template = google_compute_instance_template.instance_template.self_link_unique
    name = "primary"
  }

  named_port {
    name = var.named_port.name
    port = var.named_port.port
  }

  target_size = var.target_size
}