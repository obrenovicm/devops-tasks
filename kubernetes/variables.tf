variable "project_id" {
  type = string
}

variable "network_name" {
  type = string
}

variable "subnetworks" {
  type = list(object({
    subnet_name   = string
    ip_cidr_range = string
    region        = string
  }))
}

resource "random_id" "cluster_name" {
  byte_length = 5
}

locals {
  cluster_name = "tf-k8s-mobrenovic-${random_id.cluster_name.hex}"
}

variable "container_image" {
  type = string
}

variable "container_name" {
  type = string
}

variable "service_type" {
  type = string 
}

variable "service_port" {
  type = number
}

variable "service_target_port" {
  type = number
}