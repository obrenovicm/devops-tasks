terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.25.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.36.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region = "europe-west1"
  zone = "europe-west1-b"
}

data "google_client_config" "default" {
  depends_on = [ module.gke-cluster ]
}

data "google_container_cluster" "default" {
  name = local.cluster_name
  location = "europe-west1-b"
  depends_on = [ module.gke-cluster ]
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.default.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.default.master_auth[0].cluster_ca_certificate,
  )
}

module "vpc" {
  source = "./network"
  network_name = var.network_name
  subnetworks = var.subnetworks
}

module "gke-cluster" {
  source = "./gke-cluster"
  cluster_name = local.cluster_name
  network = module.vpc.network_link
  subnetwork = values(module.vpc.subnetwork_link)[0]
}

module "kubernetes-config" {
  source = "./kubernetes-config"
  depends_on = [ module.gke-cluster ]
  
  container_image = var.container_image
  container_name = var.container_name
  service_port = var.service_port
  service_target_port = var.service_target_port
  service_type = var.service_type
}